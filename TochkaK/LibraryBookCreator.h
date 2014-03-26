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

//transforms JSON object into an array of LibraryBooks
+ (NSArray *)booksFromJSON:(NSData *)data error:(NSError **)error;

//transfroms JSON object into single LibraryBook
+ (LibraryBook *)singleBookFromJSON:(NSData *)data error:(NSError **)error;

//transforms NSManagedObject into single LibraryBook
+ (LibraryBook *)singleBookFromNSManagedObject:(NSManagedObject *)managedObject;
@end
