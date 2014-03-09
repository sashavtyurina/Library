//
//  LibraryViewController.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryViewController.h"


@interface LibraryViewController ()
@property (strong, nonatomic) NSArray* books;
@property (strong, nonatomic) LibraryManager* manager;
@end

@implementation LibraryViewController
@synthesize books = _books;
@synthesize manager = _manager;
-(LibraryManager*) manager
{
    if (!_manager)
    {
        _manager = [[LibraryManager alloc] init];
    }
    return _manager;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.manager = [self.manager initWithSourceURL:[NSURL URLWithString:@"http://test.tochkak.ru/list.json"]];
    [self.manager getBooks];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadUI)
                                                 name:@"BOOKS_RETRIEVED"
                                               object:nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void) reloadUI
{
    self.books = self.manager.books;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[self.books objectAtIndex:[indexPath row]] valueForKey:@"title"];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LibraryDetailedBookViewController* vc = [LibraryDetailedBookViewController new];

//    LibraryDetailedBookViewController* vc = [[LibraryDetailedBookViewController alloc] initWithBook:[self.books objectAtIndex:indexPath.row]];
    vc.bookToShow = [self.books objectAtIndex:indexPath.row];
    [self presentViewController:vc animated:YES completion:nil];
}

-(int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.books.count;
}

@end
