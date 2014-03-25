//
//  LibrarySingleBookOperation.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 24/03/14.
//
//

#import "LibrarySingleBookOperation.h"
#import "LibraryBookCreator.h"
@interface LibrarySingleBookOperation()
@property (strong, nonatomic) NSData* data;
@property (strong, nonatomic) LibraryManager* manager;
@end
@implementation LibrarySingleBookOperation
-(id) initWithData:(NSData*) data manager:(LibraryManager*) manager
{
    self = [super init];
    if (self)
    {
        self.data = data;
        self.manager = manager;
    }
    return self;
}

-(void) main
{
    NSError* error = nil;
    self.manager.requestedBook = [LibraryBookCreator singleBookFromJSON:self.data error:&error];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOK_DETAILS_RETRIEVED" object:nil];
}
@end
