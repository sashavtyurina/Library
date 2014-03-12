//
//  LibraryBookCreator.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryBookCreator.h"



@implementation LibraryBookCreator

+(NSArray*) booksFromJSON: (NSData*)data error:(NSError**) error
{
    NSMutableArray* books = [[NSMutableArray alloc] init];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    NSArray* booksRaw = [json valueForKey:@"books"];
    
    for (NSDictionary* bookRaw in booksRaw) {
        NSString* title = [bookRaw valueForKey:@"title"];
        NSString* authorTitle = [bookRaw valueForKey:@"author_title"];
        BOOL free = [[bookRaw objectForKey:@"free"] boolValue];
        NSString* url = [bookRaw valueForKey:@"img"];
        NSData* image = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        LibraryBook* book = [[LibraryBook alloc]
                             initWithID: [[bookRaw objectForKey:@"id"] integerValue]
                             title:[title isEqual:[NSNull null]] ? @"Unknown name" : title
                             subtitle:@""
                             authorTitle:[authorTitle isEqual:[NSNull null]] ?@"" : authorTitle
                             url:[url isEqual:[NSNull null]] ? @"" : url
                             published:@""
                             free:free
                             description:@""
                             image:image];
        [books addObject:book];
    }
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
    NSData* image = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];

    
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
                                            description:description
                                                  image:image];
    return book;
    
}

+(LibraryBook*) singleBookFromNSManagedObject: (NSManagedObject*) managedObject
{
    NSInteger ID = [[managedObject valueForKey:@"bookID"] integerValue];
    NSString* title = [managedObject valueForKey:@"title"];
    NSString* subtitle = [managedObject valueForKey:@"subtitle"];
    NSString* authorTitle = [managedObject valueForKey:@"authorTitle"];
    NSString* url = [managedObject valueForKey:@"url"];
    NSString* published = [managedObject valueForKey:@"published"];
    BOOL free = [[managedObject valueForKey:@"free"] boolValue];
    NSString* description = [managedObject valueForKey:@"bookdescription"];
    NSData* image = [managedObject valueForKey:@"image"];
    
    
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
                                            description:description image:image];
    return book;
}
@end
