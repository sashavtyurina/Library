//
//  LibraryCommunicator.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryManager.h"
#import "LibraryServerCommunicator.h"
#import "LibraryBookCreator.h"
@interface LibraryManager ()
@property (strong, nonatomic) NSURL* sourceURL;
@property (strong, nonatomic) LibraryServerCommunicator* communicator;
@property (strong, nonatomic) LibraryBookCreator* bookCreator;


//URLConnection
    @property (strong, nonatomic, readonly) NSMutableData* dataRecieved;
    @property (strong, nonatomic) id <NSURLConnectionDelegate> delegate;

//JSONSerialization


//utility methods

@end



@implementation LibraryManager
@synthesize dataRecieved = _dataRecieved;
@synthesize delegate = _delegate;

-(LibraryBookCreator*) bookCreator
{
    if (!_bookCreator)
    {
        _bookCreator = [[LibraryBookCreator alloc] init];
    }
    return _bookCreator;
}

-(LibraryServerCommunicator*) communicator
{
    if (!_communicator)
    {
        _communicator = [[LibraryServerCommunicator alloc] init];
    }
    return _communicator;
}

-(NSArray*) getBooks
{
    [self sendRequest];
    return nil;
}

-(void) sendRequest
{
    if (!_dataRecieved)
    {
        _dataRecieved = [[NSMutableData alloc] init];
    }
    NSError* err = nil;
    [LibraryServerCommunicator sendRequestToURL:self.sourceURL withDelegate:self error:err];
    
    if (err)
    {
        _dataRecieved = nil;
    }
}

-(LibraryManager*) initWithSourceURL:(NSURL *)sourceURL
{
    self = [super init];
    if (self)
    {
        self.sourceURL = sourceURL;
    }
    return self;
}

#pragma mark NSURLConnectionDelegate, NSURLConnectionDataDelegate protocols implementation

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"NSURLResponse = %@", response.description);
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    _dataRecieved = [data mutableCopy];
    //NSLog(@"Newly arrived data = %@", self.dataRecieved.description);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Did finish loading successfully");
    NSError* err = nil;
    self.books = [self.bookCreator booksFromJSON:_dataRecieved error:&err];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];
}
@end
