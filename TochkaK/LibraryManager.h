//
//  LibraryCommunicator.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import <Foundation/Foundation.h>
#import "LibraryBookCreator.h"
@interface LibraryManager : NSObject <NSURLConnectionDelegate>
@property (strong, nonatomic) NSArray* books;
@property (weak, nonatomic) LibraryBook* requestedBook;

-(void) startGettingBooks;
-(void) startGettingDetailedDescriptionOfBookWithID:(NSInteger) ID;


-(LibraryManager*) initWithSourceURL:(NSURL*) sourceURL;

@end
