//
//  LibraryBook.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryBook.h"

@implementation LibraryBook
@synthesize ID = _id;
@synthesize title = _title;
@synthesize authorTitle = _authorTitle;
@synthesize free = _free;
@synthesize url = _url;
-(LibraryBook*) initWithID:(NSInteger) ID title:(NSString*) title authorTitle:(NSString*) authorTitle url:(NSString*)url free:(BOOL)free
{
    self = [super init];
    if (self)
    {
        self.ID = ID;
        self.title = title;
        self.authorTitle = authorTitle;
        self.url = url;
        self.free = free;
    }
    return self;
}
@end
