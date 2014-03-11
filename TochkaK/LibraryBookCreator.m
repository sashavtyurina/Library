//
//  LibraryBookCreator.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryBookCreator.h"



@implementation LibraryBookCreator
//@synthesize books = _books;
//-(NSMutableArray*) books
//{
//    if (!_books)
//    {
//        _books = [[NSMutableArray alloc] init];
//    }
//    return _books;
//}

+(NSArray*) booksFromJSON: (NSData*)data error:(NSError**) error
{
    NSMutableArray* books = [[NSMutableArray alloc] init];
//    NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", str);
    
    //NSError* err = nil;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
//    
//    if (error)
//    {
//        NSLog(@"An error occured. %@", &error.description);
//    }
    
    NSArray* booksRaw = [json valueForKey:@"books"];
    
    for (NSDictionary* bookRaw in booksRaw) {        
        LibraryBook* book = [[LibraryBook alloc]
                             initWithID: [[bookRaw objectForKey:@"id"] integerValue]
                             title:[bookRaw objectForKey:@"title"]
                             subtitle:@""
                             authorTitle:[bookRaw valueForKey:@"author_title"]
                             url:[bookRaw valueForKey:@"img"]
                             published:@""
                             free:[[bookRaw objectForKey:@"free"] boolValue]
                             description:@"" ];
        
        //[self.books addObject:book];
        [books addObject:book];
    }
    //NSLog(@"Count = %d", booksRaw.count);
    
    
    
    return  books;
}

+(LibraryBook*) singleBookFromJSON:(NSData*)data error:(NSError**)error
{
    
    NSDictionary* jsonRaw = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    NSDictionary* json = jsonRaw[@"book"];
    NSInteger ID = [[json valueForKey:@"id"] integerValue];
    NSString* title = [json valueForKey:@"title"];
    NSString* subtitle = [json valueForKey:@"subtitle"];
    NSString* authorTitle = [json valueForKey:@"author_title"];
    NSString* url = [json valueForKey:@"img"];
    NSString* published = [json valueForKey:@"published"];
    BOOL free = [[json valueForKey:@"free"] boolValue];
    NSString* description = [json valueForKey:@"description"];

    
    title = [title isEqual:[NSNull null]] ? @"Unknown name" : title;
    authorTitle = [authorTitle isEqual:[NSNull null]] ? @"Unknown author" : authorTitle;
    url = [url isEqual:[NSNull null]] ? @"" : url;
    description = [description isEqual:[NSNull null]] ? @"No description available" : description;
    published = [published isEqual:[NSNull null]] ? @"" : published;
    subtitle = [subtitle isEqual:[NSNull null]] ? @"" : subtitle;

    
    LibraryBook* book = [[LibraryBook alloc] initWithID:ID
                                                  title:title
                                               subtitle:subtitle
                                            authorTitle:authorTitle
                                                    url:url
                                              published:published
                                                   free:free
                                            description:description];    
    return book;
    
}
@end
