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
@property NSInteger requstedBookID;
//JSONSerialization


//utility methods

@end



@implementation LibraryManager
@synthesize dataRecieved = _dataRecieved;
@synthesize delegate = _delegate;
@synthesize getBooksConnection = _getBooksConnection;

-(void) backupDBFromServer
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
    LibraryAppDelegate* appDelegate = (LibraryAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [appDelegate managedObjectContext];
    
    for (LibraryBook* book in self.books) {
        
        //[self startGettingDetailedDescriptionOfBookWithID:book.ID];
        
        NSManagedObject* bookObject = [NSEntityDescription insertNewObjectForEntityForName:@"Book"
                                                                    inManagedObjectContext:context];
        [bookObject setValue:[NSNumber numberWithInt:book.ID] forKey:@"bookID"];
        [bookObject setValue:book.title forKey:@"title"];
        [bookObject setValue:book.authorTitle forKey:@"authorTitle"];
        [bookObject setValue:[NSNumber numberWithBool:book.free] forKey:@"free"];
        NSData* img = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.url]];
        [bookObject setValue:img forKey:@"image"];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
}
-(void) copyBookToDB: (LibraryBook*) book
{
    LibraryAppDelegate* appDelegate = (LibraryAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [appDelegate managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Book"
                                                         inManagedObjectContext:context];
    [request setEntity:entityDescription];
    NSError* err = nil;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"bookID = %d ", book.ID];
    [request setPredicate:predicate];
    NSArray* requstedBook = [context executeFetchRequest:request error:&err];
    
    if (!([requstedBook lastObject] == nil))
    {
        NSManagedObject* bookObject = [requstedBook lastObject];
        NSString* subtitle = [bookObject valueForKey:@"subtitle"];
        if (subtitle == nil)
        {
            [bookObject setValue:book.subTitle forKey:@"subtitle"];
            [bookObject setValue:book.published forKey:@"published"];
            [bookObject setValue:book.description forKey:@"bookdescription"];
            
            NSError *error;
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
        }
    }

}

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
    self.requstedBookID = ID;
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
        }
        
    }
    else if (connection == self.detailedBooksConnection)
    {
        self.detailedBooksConnection = [LibraryServerCommunicator sendRequestToURL:url withDelegate:self succeed:success];
        if (!success)
        {
            
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
        [self backupDBFromServer];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];
    }
    else if (connection == self.detailedBooksConnection)
    {
        NSError* err = nil;
        self.requestedBook = [LibraryBookCreator singleBookFromJSON:_dataRecieved error:&err];
        [self copyBookToDB:self.requestedBook];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOK_DETAILS_RETRIEVED" object:nil];
    }
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//    NSLog(@"fail with error");
    //load from local DB
    if (connection == self.getBooksConnection)
    {
        //Dtabase manager get list of books
        NSFetchRequest* request = [[NSFetchRequest alloc] init];
        NSManagedObjectContext* context = [(LibraryAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Book"
                                                             inManagedObjectContext:context];
        [request setEntity:entityDescription];
        NSError* err = nil;
        NSArray* fetchedObjects = [context executeFetchRequest:request error:&err];
        NSMutableArray* booksMutableArray = [[NSMutableArray alloc] init];
        for (NSManagedObject* bookObject in fetchedObjects) {
            [booksMutableArray addObject: [LibraryBookCreator singleBookFromNSManagedObject:bookObject ]];
        }
        self.books = booksMutableArray;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];

    }
    else if (connection == self.detailedBooksConnection)
    {
        //Database manager get detailed description for book with ID
        NSFetchRequest* request = [[NSFetchRequest alloc] init];
        NSManagedObjectContext* context = [(LibraryAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Book"
                                                             inManagedObjectContext:context];
        [request setEntity:entityDescription];
        NSError* err = nil;
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"bookID = %d ", self.requstedBookID];
        [request setPredicate:predicate];
        NSArray* requstedBook = [context executeFetchRequest:request error:&err];
        if ([requstedBook lastObject] != nil)
        {
            LibraryBook* b = [LibraryBookCreator singleBookFromNSManagedObject:[requstedBook lastObject]];
            self.requestedBook = b;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOK_DETAILS_RETRIEVED" object:nil];
        }
    }
}
@end
