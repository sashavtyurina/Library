//
//  LibraryServerCommunicator.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import <Foundation/Foundation.h>

@interface LibraryServerCommunicator : NSObject
//@property (strong, nonatomic)id<NSURLConnectionDelegate> delegate;
//@property (strong, nonatomic) NSURL* sourceURL;

+(NSURLConnection*) sendRequestToURL:(NSURL *)sourceURL withDelegate:(id<NSURLConnectionDelegate>)delegate succeed:(BOOL)succeed;
@end
