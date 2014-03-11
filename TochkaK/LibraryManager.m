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
//@property (strong, nonatomic) LibraryServerCommunicator* communicator;
//@property (strong, nonatomic) LibraryBookCreator* bookCreator;


//URLConnection
@property (strong, nonatomic) NSMutableData* dataRecieved;
@property (strong, nonatomic) id <NSURLConnectionDelegate> delegate;
@property (strong, nonatomic) NSURLConnection* getBooksConnection;
@property (strong, nonatomic) NSURLConnection* detailedBooksConnection;
//JSONSerialization


//utility methods

@end



@implementation LibraryManager
@synthesize dataRecieved = _dataRecieved;
@synthesize delegate = _delegate;
@synthesize getBooksConnection = _getBooksConnection;


//-(LibraryBookCreator*) bookCreator
//{
//    if (!_bookCreator)
//    {
//        _bookCreator = [[LibraryBookCreator alloc] init];
//    }
//    return _bookCreator;
//}

//-(LibraryServerCommunicator*) communicator
//{
//    if (!_communicator)
//    {
//        _communicator = [[LibraryServerCommunicator alloc] init];
//    }
//    return _communicator;
//}


-(void) startGettingBooks
{
    [self sendRequestToURL:[NSURL URLWithString:@"http://test.tochkak.ru/list.json"] connection:self.getBooksConnection];
}

-(NSURL*) constructURLForBookWithID:(NSInteger) ID
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://test.tochkak.ru/item.json?id=%d", ID]];
}

-(void) startGettingDetailedDescriptionOfBookWithID:(NSInteger)ID
{
    [self sendRequestToURL:[self constructURLForBookWithID:ID] connection:self.detailedBooksConnection];
}

-(void) sendRequestToURL:(NSURL*) url connection:(NSURLConnection*) connection
{
    BOOL success = YES;
    
    if (!_dataRecieved)
    {
        _dataRecieved = [[NSMutableData alloc] init];
    }
    
    if (connection == self.getBooksConnection)
    {
        self.getBooksConnection = [LibraryServerCommunicator sendRequestToURL:url withDelegate:self succeed:success];
        if (!success)
        {
            //Dtabase manager get list of books
        }
        
    }
    else if (connection == self.detailedBooksConnection)
    {
        self.detailedBooksConnection = [LibraryServerCommunicator sendRequestToURL:url withDelegate:self succeed:success];
        if (!success)
        {
            //Database manager get detailed description for book with ID
        }
//        if (!self.detailedBooksConnection)
//        {
//            _dataRecieved = nil;
//        }
    }
    if (!success)//(!self.getBooksConnection)
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
{}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    _dataRecieved = nil;
    _dataRecieved = [data mutableCopy];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == self.getBooksConnection)
    {
        NSError* err = nil;
        self.books = [LibraryBookCreator booksFromJSON:_dataRecieved error:&err];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];
    }
    else if (connection == self.detailedBooksConnection)
    {
        NSError* err = nil;
        self.requestedBook = [LibraryBookCreator singleBookFromJSON:_dataRecieved error:&err];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOK_DETAILS_RETRIEVED" object:nil];
    }
}
@end
