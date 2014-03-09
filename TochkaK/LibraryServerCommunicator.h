//
//  LibraryServerCommunicator.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import <Foundation/Foundation.h>

@interface LibraryServerCommunicator : NSObject
@property (strong, nonatomic)id<NSURLConnectionDelegate> delegate;
@property (strong, nonatomic) NSURL* sourceURL;

//-(LibraryServerCommunicator*) initWithURL: (NSURL*) sourceURL delegate: (id<NSURLConnectionDelegate>) delegate;
//-(void) sendRequest;

+(void) sendRequestToURL:(NSURL*) sourceURL withDelegate:(id<NSURLConnectionDelegate>) delegate error:(NSError*) error;
@end
