
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
    cell.coverImage.image = nil;
    cell.titleLabel.text = @"";
    cell.authorLabel.text = @"";
    cell.priceLabel.text = @"";
    
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

        [[LibraryImageManager sharedManager] startProcessingImageView:cell.coverImage withURL:bookPresenting.url];
        
        // 0. Add cell.coverImageView with imageURL to ImageManager, let it do its job
//        [[LibraryImageManager sharedManager] addImageView:cell.coverImage withURL:[NSURL URLWithString:bookPresenting.url]];
        
        
        //0. create a separate directory where all the pictures will be saved - done. In AppDelegate didFinishLoadingWithOptions
        //0.1. create a unique name for a file to save (sha / md5) - ok. SHA-1 it is.
        //1. check if the needed file exists - ok
        //2. if exists - load it from the disk - ok?
        //3. if doesn't exist - load it from the server - ok
        //4. save it to the disk
        //5. create a separate NSOperation for this stuff
        
//        NSString *hashedFileName = [bookPresenting.url MD5String];
//
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//        NSString *filePath = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", hashedFileName]];
////        NSLog(@"Hashed name: %@; Title: %@", filePath, bookPresenting.title);
//        
//        BOOL fileExists = [fileManager fileExistsAtPath:filePath];
//        
//        NSLog(@"Does file exist? -%hhd", fileExists);
//        NSData *coverImageData = nil;
//        
//        if (fileExists) {
//            coverImageData = [NSData dataWithContentsOfFile:filePath];
//            NSLog(@"file exists, load it from the disk");
//        } else {
        
//            //save file to disk
//            BOOL fileCreated = [fileManager createFileAtPath:filePath contents:coverImageData attributes:nil];
//
//            if (!fileCreated) {
//                NSLog(@"Could not create a file");
//            }
//        }
        
        
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:bookPresenting.url]];
//        NSURLResponse *response = nil;
//        NSError *err = nil;
//        NSData *coverImageData = [NSURLConnection sendSynchronousRequest:request
//                                                       returningResponse:&response
//                                                                   error:&err];
//                              
//        UIImage *img = [UIImage imageWithData:coverImageData];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.coverImage.image = img;
//        });
    });
    
    return cell;
}

- (void)enumerateFilesInDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *bundleURL = [[NSBundle mainBundle] bundleURL];
    NSArray *contents = [fileManager contentsOfDirectoryAtURL:bundleURL
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:nil];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension == 'jpg'"];
    for (NSURL *fileURL in [contents filteredArrayUsingPredicate:predicate]) {
        // Enumerate each .png file in directory
        NSLog(@"%@", fileURL);
    }
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
