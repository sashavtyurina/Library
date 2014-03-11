//
//  LibraryAppDelegate.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 07/03/14.
//
//

#import <UIKit/UIKit.h>
#import "LibraryViewController.h"
//#import "LibraryTabBarViewController.h"
@interface LibraryAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//@property (readonly, strong, nonatomic) LibraryTabBarViewController *rootViewController;
@property (strong, nonatomic) UITabBarController* tabBarController;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
