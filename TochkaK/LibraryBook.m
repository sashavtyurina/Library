//
//  LibraryBook.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryBook.h"

@implementation LibraryBook
//@synthesize ID = _id;
//@synthesize title = _title;
//@synthesize authorTitle = _authorTitle;
//@synthesize free = _free;
//@synthesize url = _url;
//@synthesize description = _description;
//@synthesize subTitle = _subTitle;
//@synthesize published = _published;

-(LibraryBook*) initWithID:(NSInteger) ID
                     title:(NSString*) title
                  subtitle:(NSString *)subtitle
               authorTitle:(NSString *)authorTitle
                       url:(NSString *)url
                 published:(NSString *)published
                      free:(BOOL)free
               description:(NSString *)description
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
    }
    return self;
}
@end
