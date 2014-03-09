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
-(NSArray*) getBooks;
-(LibraryManager*) initWithSourceURL:(NSURL*) sourceURL;

@end
