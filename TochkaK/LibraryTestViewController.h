//
//  LibraryTestViewController.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 26/03/14.
//
//

#import <UIKit/UIKit.h>
#import "LibraryBook.h"
@interface LibraryTestViewController : UIViewController

@property (strong, nonatomic) LibraryBook *bookToShow;

- (void)updateUI;

@end
