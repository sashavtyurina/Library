//
//  LibraryBook.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import <Foundation/Foundation.h>

@interface LibraryBook : NSObject
@property (nonatomic)NSInteger ID;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* authorTitle;
@property (strong, nonatomic) NSString* url;
@property (nonatomic) BOOL free;

-(LibraryBook*) initWithID:(NSInteger) ID title:(NSString*) title authorTitle:(NSString*) authorTitle url:(NSString*)url free:(BOOL)free;
@end
