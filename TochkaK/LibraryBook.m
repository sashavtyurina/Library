//
//  LibraryBook.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryBook.h"

@implementation LibraryBook

-(LibraryBook*) initWithID:(NSInteger) ID
                     title:(NSString*) title
                  subtitle:(NSString *)subtitle
               authorTitle:(NSString *)authorTitle
                       url:(NSString *)url
                 published:(NSString *)published
                      free:(BOOL)free
               description:(NSString *)description
                     image:(NSData *)image
{
    self = [super init];
    if (self)
    {
        self.ID = ID;
        self.title = title;
        self.subTitle = subtitle;
        self.authorTitle = authorTitle;
        self.url = url;
        self.published = published;
        self.free = free;
        self.description = description;
        self.image = image;
    }
    return self;
}

@end
