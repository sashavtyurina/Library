//
//  LibraryTabBarViewController.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 09/03/14.
//
//

#import "LibraryTabBarViewController.h"

@interface LibraryTabBarViewController ()

@end

@implementation LibraryTabBarViewController

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
    self.delegate = self;
//	// Do any additional setup after loading the view.
//    LibraryViewController* titlesVC = [[LibraryViewController alloc] init];
//    titlesVC.order = TITLE;
//    UITabBarItem* titlesTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Titles" image:nil tag:1];
//    titlesVC.tabBarItem = titlesTabBarItem;
//    
//    LibraryViewController* authorsVC = [[LibraryViewController alloc] init];
//    authorsVC.order = AUTHOR_TITLE;
//   
//    
//    LibraryViewController* priceVC = [[LibraryViewController alloc] init];
//    priceVC.order = PRICE;
//    UITabBarItem* priceTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Price" image:nil tag:1];
//    priceVC.tabBarItem = priceTabBarItem;
//    
//    //LibraryViewController* vc4 = [[LibraryViewController alloc] init];
//    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:titlesVC];
//    
//    self.viewControllers = [NSArray arrayWithObjects:titlesVC, authorsVC, priceVC, navController, nil];
//    self.selectedViewController = titlesVC;
//    
//    UINavigationBar* bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,320,50)];
//    [self.view addSubview:bar];
    
    LibraryViewController* titlesVC = [[LibraryViewController alloc] init];
    titlesVC.order = TITLE;
    titlesVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Titles" image:nil tag:1];
    
    UINavigationController* titlesNavController = [[UINavigationController alloc] initWithRootViewController:titlesVC];
    
    LibraryViewController* authorsVC = [[LibraryViewController alloc] init];
    authorsVC.order = AUTHOR_TITLE;
    authorsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Authors" image:nil tag:2];
    UINavigationController* authorTitlesNavController = [[UINavigationController alloc] initWithRootViewController:authorsVC];
    
    LibraryViewController* priceVC = [[LibraryViewController alloc] init];
    priceVC.order = PRICE;
    priceVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Price" image:nil tag:3];
    UINavigationController* priceNavController = [[UINavigationController alloc] initWithRootViewController:priceVC];
    
    NSArray* controllers = [NSArray arrayWithObjects:titlesNavController,authorTitlesNavController, priceNavController, nil];
    self.tabBarController.viewControllers = controllers;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
