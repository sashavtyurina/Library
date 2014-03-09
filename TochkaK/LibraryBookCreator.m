//
//  LibraryBookCreator.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryBookCreator.h"

@implementation LibraryBookCreator
@synthesize books = _books;
-(NSMutableArray*) books
{
    if (!_books)
    {
        _books = [[NSMutableArray alloc] init];
    }
    return _books;
}

-(NSArray*) booksFromJSON: (NSData*)data error:(NSError**) error
{
    //convert dataRecieved to JSON object
    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
    
    NSError* err = nil;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    
    if (err)
    {
        NSLog(@"An error occured. %@", err.description);
    }
    
    NSArray* booksRaw = [json valueForKey:@"books"];
    
    for (NSDictionary* bookRaw in booksRaw) {        
        LibraryBook* book = [[LibraryBook alloc]
                             initWithID: [[bookRaw objectForKey:@"id"] integerValue]
                             title:[bookRaw objectForKey:@"title"]
                             authorTitle:[bookRaw valueForKey:@"author_title"]
                             url:[bookRaw valueForKey:@"img"]
                             free:[[bookRaw objectForKey:@"free"] boolValue]];
        [self.books addObject:book];
    }
    NSLog(@"Count = %d", booksRaw.count);
    
    
    
    return  self.books;
}

-(void) complementBook:(LibraryBook*) book withDetailedDescription:(NSData*) complementaryData
{}
@end
