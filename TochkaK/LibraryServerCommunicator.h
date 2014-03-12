//
//  LibraryServerCommunicator.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import <Foundation/Foundation.h>

@interface LibraryServerCommunicator : NSObject

//sends request to URL, sets up a delegate
+(NSURLConnection*) sendRequestToURL:(NSURL *)sourceURL withDelegate:(id<NSURLConnectionDelegate>)delegate;
@end
