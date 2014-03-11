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
@property (strong, nonatomic) NSString* subTitle;
@property (strong, nonatomic) NSString* authorTitle;
@property (strong, nonatomic) NSString* url;
@property (strong, nonatomic) NSString* published;
@property (nonatomic) BOOL free;
@property (strong, nonatomic) NSString* description;

-(LibraryBook*) initWithID:(NSInteger) ID
                     title:(NSString*) title
                  subtitle:(NSString*) subtitle
               authorTitle:(NSString*) authorTitle
                       url:(NSString*)url
                 published:(NSString*) published
                      free:(BOOL)free
               description:(NSString*) description;
@end
