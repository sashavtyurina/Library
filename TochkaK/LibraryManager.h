//
//  LibraryCommunicator.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import <Foundation/Foundation.h>
#import "LibraryBookCreator.h"
#import "LibraryAppDelegate.h"
#import "LibraryConstants.h"
//@protocol SingleBookOperationDelegate <NSObject>
//
//@required - (LibraryBook *)saveRequestedLibraryBook:(LibraryBook *)requestedLibraryBook;
//
//@end


@interface LibraryManager : NSObject

//singleton
+ (instancetype)sharedManager;

//A collection of books
@property (strong, nonatomic) NSArray *books;

//A single book  currently requested
@property (strong, nonatomic) LibraryBook *requestedBook;

//get the list of the books
- (void)requestBooksList;

//get detailed description of a particular book with ID
- (void)requestDetailedBookWithID:(NSInteger)requestedBookID;

@end


