//
//  LibraryServerCommunicator.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryServerCommunicator.h"

@implementation LibraryServerCommunicator
//-(LibraryServerCommunicator*) initWithURL: (NSURL*) sourceURL delegate: (id<NSURLConnectionDelegate>) delegate
//{
//    self = [super init];
//    if (!self)
//    {
//        
//    }
//}
//
//-(void) sendRequest
//{
//}

+(void) sendRequestToURL:(NSURL *)sourceURL withDelegate:(id<NSURLConnectionDelegate>)delegate error:(NSError*)error
{
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:sourceURL] delegate:delegate];
    
    if (!theConnection)
    {
        NSLog(@"connection failed");
    }

}
@end
