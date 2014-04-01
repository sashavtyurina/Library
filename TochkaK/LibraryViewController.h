//
//  LibraryViewController.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import <UIKit/UIKit.h>
#import "LibraryManager.h"
#import "LibraryDetailedBookViewController.h"
#import "LibraryTableViewCell.h"

#include <CommonCrypto/CommonDigest.h>
#import "NSString+MD5Hash.h"
#import "LibraryDownloadImageOperation.h"
#import "LibraryImageManager.h"

enum sortingOrder {
    TITLE = 1,
    AUTHOR_TITLE = 2,
    PRICE = 3
};

@interface LibraryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//an order according to wich the books in the table are sorted
@property (nonatomic) enum sortingOrder order;
@end
