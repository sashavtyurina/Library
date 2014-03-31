
//  LibraryViewController.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryViewController.h"


@interface LibraryViewController ()
@property (strong, nonatomic) NSArray *books;
@property (strong, nonatomic) LibraryManager *manager;

@property (strong, nonatomic) UINavigationBar *navigationBar;
@property (strong, nonatomic) LibraryDetailedBookViewController *currentDetailedVC;

@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;

@end

@implementation LibraryViewController

- (UINavigationBar *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    }
    return _navigationBar;
}

- (LibraryManager *)manager {
    return [LibraryManager sharedManager];
}

- (LibraryDetailedBookViewController *)currentDetailedVC {
    if (!_currentDetailedVC) {
        //_currentDetailedVC = [[LibraryDetailedBookViewController alloc] init];
        _currentDetailedVC = [[UIStoryboard storyboardWithName:@"main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailedBookViewController"];//@"TestViewController"];
    }
    return _currentDetailedVC;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"did load");
//    [self.view addSubview:self.tableView];
//    
    [self.manager requestBooksList];
//
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadUI)
                                                 name:@"BOOKS_RETRIEVED"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(repopulateCurrentDetailedVC)
                                                 name:BookDetailsIsReadyToBePresented
                                               object:nil];
    self.tableViewOutlet.delegate = self;
    self.tableViewOutlet.dataSource = self;
}

- (void)repopulateCurrentDetailedVC {
    
    UITabBarController *parent = self.tabBarController;
    NSInteger selectedIndex = parent.selectedIndex;
    NSInteger myIndex = [parent.viewControllers indexOfObject:self.navigationController];
    
    if (selectedIndex == myIndex) {
        self.currentDetailedVC.bookToShow = [[LibraryManager sharedManager] requestedBook];
        [self.currentDetailedVC updateUI];
    }
}
- (void)reloadUI {
    self.books = [self.manager.books sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        switch (self.order) {
            case TITLE: {
                NSString* s1 = [obj1 valueForKey:@"title"];
                NSString* s2 = [obj2 valueForKey:@"title"];
                return [s1 compare:s2];
                break;
            }
            case AUTHOR_TITLE: {
                NSString* s1 = [obj1 valueForKey:@"authorTitle"];
                NSString* s2 = [obj2 valueForKey:@"authorTitle"];
                if ([s1 isEqual:[NSNull null]]) { s1 = @""; }
                if ([s2 isEqual:[NSNull null]]) { s2 = @""; }
                return [s1 compare:s2];
                break;
            }
            case PRICE: {
                BOOL b1 = [[obj1 valueForKey:@"free"] boolValue];
                BOOL b2 = [[obj2 valueForKey:@"free"] boolValue];
                if (!b1 && b2) return NSOrderedDescending;
                if (b1 && !b2) return NSOrderedAscending;
                return NSOrderedSame;
                break;
            }
            default:
                break;
        }
    }];
    
    [self.tableViewOutlet reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    LibraryTableViewCell *cell = [[LibraryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    LibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    LibraryBook *bookPresenting = [self.books objectAtIndex:[indexPath row]];
    NSString *title =  bookPresenting.title; //[[self.books objectAtIndex:[indexPath row]] valueForKey:@"title"];
    if ([title isEqual:[NSNull null]]) { title = @"Unknown name"; }
    
//    cell.textLabel.text = title;
    
    NSString *authorTitle =  bookPresenting.authorTitle; //[[self.books objectAtIndex:[indexPath row]] valueForKey:@"authorTitle"];
    if ([authorTitle isEqualToString:@""]) { authorTitle = @"Unknown author"; }
    
    BOOL free = bookPresenting.free; //[[[self.books objectAtIndex:[indexPath row]] valueForKey:@"free"] boolValue];
    NSString *price = free ? @"free" : @"$$$";
    
    
    cell.titleLabel.text = title;
    cell.authorLabel.text = authorTitle;
    cell.priceLabel.text = price;
    
    //use dispatch concurrent queues here to load and show pictures concurrently
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(aQueue, ^{

        //0. create a separate directory where all the pictures will be saved - done. In AppDelegate didFinishLoadingWithOptions
        //0.1. create a unique name for a file to save (sha / md5) - ok. SHA-1 it is.
        //1. check if the needed file exists - ok
        //2. if exists - load it from the disk - ok?
        //3. if doesn't exist - load it from the server - ok
        //4. save it to the disk
        //5. create a separate NSOperation for this stuff
        
        unsigned char hashedFileName[CC_SHA1_DIGEST_LENGTH];
        NSData *nameToBeHashed = [bookPresenting.url dataUsingEncoding:NSUTF8StringEncoding];
        CC_SHA1([nameToBeHashed bytes], [nameToBeHashed length], hashedFileName);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%s.jpg", hashedFileName]];
        BOOL fileExists = [fileManager fileExistsAtPath:filePath];
        NSLog(@"Does file exist? -%hhd", fileExists);
        NSData *coverImageData = nil;
        if (fileExists) {
            coverImageData = [NSData dataWithContentsOfFile:filePath];
            NSLog(@"file exists, load it from the disk");
        }
        else {
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:bookPresenting.url]];
            NSURLResponse *response = nil;
            NSError *err = nil;
            coverImageData = [NSURLConnection sendSynchronousRequest:request
                                                   returningResponse:&response
                                                               error:&err];
            NSLog(@"file doesn't exist. Load it from the server");
            
            //save file to disk
            BOOL fileCreated = [fileManager createFileAtPath:filePath contents:coverImageData attributes:nil];
            NSLog(@"Was file created? %hhd", fileCreated);
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.coverImage.image = [UIImage imageWithData:coverImageData];
            
           
            
        });
    });
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LibraryBook *book = [self.books objectAtIndex:indexPath.row];
    
    //how can self.manager be a nil?! it's a singleton
    [[LibraryManager sharedManager] requestDetailedBookWithID:book.ID];
    
    [self.navigationController pushViewController:self.currentDetailedVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)self.books.count;
}

@end
