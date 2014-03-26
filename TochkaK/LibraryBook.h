//
//  LibraryBook.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import <Foundation/Foundation.h>

@interface LibraryBook : NSObject
@property (assign, nonatomic)NSInteger ID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subTitle;
@property (strong, nonatomic) NSString *authorTitle;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *published;
@property (assign, nonatomic) BOOL free;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSData *image;

//ID - book's identifier
//title - book's title
//subtitle - book's subtitle
//authorTitle - the name of the author
//url - url of book's cover image
//published - the date of publishing
//free - whether the book is free
//description - a brief description of the book
//image - binary representation of book's cover image

- (LibraryBook *)initWithID:(NSInteger)ID
                     title:(NSString *)title
                  subtitle:(NSString *)subtitle
               authorTitle:(NSString *)authorTitle
                       url:(NSString *)url
                 published:(NSString *)published
                      free:(BOOL)free
               description:(NSString *)description
                     image:(NSData *)image;


@end
