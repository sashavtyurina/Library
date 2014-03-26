//
//  LibraryServerCommunicator.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryServerCommunicator.h"

@implementation LibraryServerCommunicator

+ (NSURLConnection *)sendRequestToURL:(NSURL *)sourceURL withDelegate:(id<NSURLConnectionDelegate>)delegate {
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:sourceURL] delegate:delegate];
    if (!theConnection) {
        NSLog(@"connection failed");
    }
    return theConnection;
}

@end
