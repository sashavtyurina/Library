//
//  LibrarySingleBookOperation.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 24/03/14.
//
//

#import <Foundation/Foundation.h>
#import "LibraryManager.h"
#import "LibraryConstants.h"
@interface LibrarySingleBookOperation : NSOperation
@property (strong, nonatomic) LibraryBook* requestedBook;
- (id)initWithBookID:(int)requestedBookID;
@end
