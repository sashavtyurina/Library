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

@interface LibraryManager : NSObject //<NSURLConnectionDelegate>

+(id) sharedManager;

//A collection of books
@property (strong, nonatomic) NSArray* books;

//A single book  currently requested
@property (weak, nonatomic) LibraryBook* requestedBook;

//sourceURL - initial address of the book storage
//-(LibraryManager*) initWithSourceURL:(NSURL*) sourceURL;

//get the list of the books
-(void) startGettingBooks;

//get a particular book with identifier ID
-(void) startGettingDetailedDescriptionOfBookWithID:(NSInteger) ID;

@end
