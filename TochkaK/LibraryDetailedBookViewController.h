//
//  LibraryDetailedBookViewController.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 09/03/14.
//
//

#import <UIKit/UIKit.h>
#import "LibraryBook.h"
#import "LibraryCustomizedDetailedView.h"
#import "UIImageView+Cache.h"

//ViewController that shows the detailed information about a chosen book
@interface LibraryDetailedBookViewController : UIViewController

@property (strong, nonatomic) LibraryBook *bookToShow;

- (void)updateUI;
- (void)clearContents;

@end
