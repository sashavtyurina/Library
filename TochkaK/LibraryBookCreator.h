//
//  LibraryBookCreator.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import <Foundation/Foundation.h>
#import "LibraryBook.h"

@interface LibraryBookCreator : NSObject
//@property (strong, nonatomic) NSMutableArray* books;

+(NSArray*) booksFromJSON: (NSData*)data error:(NSError**) error;

//-(void) complementBook:(LibraryBook*) book withDetailedDescription:(NSData*) complementaryData;
+(LibraryBook*) singleBookFromJSON:(NSData*)data error:(NSError**)error;
@end
