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
#import "LibraryOperation.h"
#import "LibrarySingleBookOperation.h"

@interface LibraryManager ()
@property (strong, nonatomic) NSURL* sourceURL;

//URLConnection
@property (strong, nonatomic) NSMutableData* dataRecieved;
@property (strong, nonatomic) NSURLConnection* getBooksConnection;
@property (strong, nonatomic) NSURLConnection* detailedBooksConnection;
@property NSInteger requstedBookID;

//utility methods
@property (strong, nonatomic) NSOperationQueue* operationQueue;
@property (strong, nonatomic) LibraryOperation* getBooksListOperation;

//creates local copy of the Library
-(void) backupDBFromServer;

//copies detailed info about the book into a local storage
-(void) copyBookToDB: (LibraryBook*) book;

//constructs URL that contains detailed info about the book with ID
-(NSURL*) constructURLForBookWithID:(NSInteger) ID;

//sends the request to the URL
-(void) sendRequestToURL:(NSURL*) url connection:(NSURLConnection*) connection;
@end



@implementation LibraryManager

+(id) sharedManager
{
    static LibraryManager *sharedLibraryManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        sharedLibraryManager = [[self alloc] initWithSourceURL:[NSURL URLWithString:@"http://test.tochkak.ru/list.json"]];
        sharedLibraryManager = [[self alloc] init];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(copyBookToDB:)
//                                                     name:@"BOOK_DETAILS_RETRIEVED"
//                                                   object:self.requestedBook];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                    selector:@selector(backupDBFromServer)
                                                    name:@"BOOKS_RETRIEVED"
                                                    object:nil];
    });
    return sharedLibraryManager;
}


-(LibraryOperation*) getBooksListOperation
{
    if (!_getBooksListOperation)
    {
        _getBooksListOperation = [[LibraryOperation alloc] initWithData:self.dataRecieved manager:[LibraryManager sharedManager]];
    }
    return _getBooksListOperation;
}

-(NSOperationQueue*) operationQueue
{
    if (!_operationQueue)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        [_operationQueue setMaxConcurrentOperationCount:1];
    }
    return  _operationQueue;
}

//-(LibraryManager*) initWithSourceURL:(NSURL *)sourceURL
//{
//    self = [super init];
//    if (self)
//    {
//        self.sourceURL = sourceURL;
//    }
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(copyBookToDB:)
//                                                 name:@"BOOK_DETAILS_RETRIEVED"
//                                               object:self.requestedBook];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(backupDBFromServer)
//                                                 name:@"BOOKS_RETRIEVED"
//                                               object:nil];
//    return self;
//}

//-(NSArray*) getAllBooksFromDB
//{
//    NSFetchRequest* request = [[NSFetchRequest alloc] init];
//    NSManagedObjectContext* context = [(LibraryAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
//    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Book"
//                                                         inManagedObjectContext:context];
//    [request setEntity:entityDescription];
//    NSError* err = nil;
//    NSArray* fetchedObjects = [context executeFetchRequest:request error:&err];
//    return fetchedObjects;
//}

-(void) startGettingBooks
{
    
    LibraryOperation* operation = [[LibraryOperation alloc] initWithURL:[NSURL URLWithString:@"http://test.tochkak.ru/list.json"] manager:[LibraryManager sharedManager]];
    [self.operationQueue addOperation:operation];
    
//    NSArray* fetchedObjects = [self fetchBooksFromDB];
//    if (![[fetchedObjects lastObject] isEqual:[NSNull null]])
//    {
//        [self transfromFetchedObjectsToBooks:fetchedObjects];
//    }
//    
//    else
//    {
//        [self sendRequestToURL:[NSURL URLWithString:@"http://test.tochkak.ru/list.json"] connection:self.getBooksConnection];
//    }

    
//    NSFetchRequest* request = [[NSFetchRequest alloc] init];
//    NSManagedObjectContext* context = [(LibraryAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
//    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Book"
//                                                         inManagedObjectContext:context];
//    
//    [request setEntity:entityDescription];
//    NSError* err = nil;
//    NSArray* fetchedObjects = [context executeFetchRequest:request error:&err];
//    
//    if ([[fetchedObjects lastObject] isEqual: [NSNull null]])
//    {
//        LibraryOperation* operation = [[LibraryOperation alloc] initWithURL:[NSURL URLWithString: @"http://test.tochkak.ru/list.json"] manager:self];
//        [self.operationQueue addOperation:operation];
//    }
//    else
//    {
//        NSMutableArray* booksMutableArray = [[NSMutableArray alloc] init];
//        for (NSManagedObject* bookObject in fetchedObjects) {
//            [booksMutableArray addObject: [LibraryBookCreator singleBookFromNSManagedObject:bookObject ]];
//        }
//        self.books = booksMutableArray;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];
//    }
    
    



 //   [self sendRequestToURL:[NSURL URLWithString:@"http://test.tochkak.ru/list.json"] connection:self.getBooksConnection];
    
    
//    //check if we've got something stored in the DB
//    // if the DB is empty. We go to the server and try to get the data
//    NSArray* fetchedObjects = [self getAllBooksFromDB];
//    if ([[fetchedObjects lastObject] isEqual:[NSNull null]])
//    {
//        
//    }
//    else
//    //there's something in the DB. Process the data.
//    //we have already got a cached copy of the data needed
//    {
//        NSMutableArray* booksMutableArray = [[NSMutableArray alloc] init];
//        for (NSManagedObject* bookObject in fetchedObjects) {
//            [booksMutableArray addObject: [LibraryBookCreator singleBookFromNSManagedObject:bookObject ]];
//        }
//        self.books = booksMutableArray;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];
//    }
//    

    
    
    //we have already got a cached copy of the data needed
    //
    
//    if (![self.getBooksListOperation valueForKey:@"isFinished"])
//    if (!([self.getBooksListOperation valueForKey:@"isFinished"]||[self.getBooksListOperation valueForKey:@"isExecuting"]))
//    {
    
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];
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


-(void) backupDBFromServer
{
    //check if the app is launched for the first time
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
    LibraryAppDelegate* appDelegate = (LibraryAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = [appDelegate managedObjectContext];
    
    //save the essential information about each book in the local storage
    for (LibraryBook* book in self.books) {
        NSManagedObject* bookObject = [NSEntityDescription insertNewObjectForEntityForName:@"Book"
                                                                    inManagedObjectContext:context];
        [bookObject setValue:[NSNumber numberWithInt:book.ID] forKey:@"bookID"];
        [bookObject setValue:book.title forKey:@"title"];
        [bookObject setValue:book.authorTitle forKey:@"authorTitle"];
        [bookObject setValue:[NSNumber numberWithBool:book.free] forKey:@"free"];
        NSData* img = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.url]];
        [bookObject setValue:img forKey:@"image"];
        
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

}

-(void) copyBookToDB: (LibraryBook*) book
{
    book = self.requestedBook; // initial value is not passed. why?
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
        //complement the book in the local storage with the details
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

-(void) sendRequestToURL:(NSURL*) url connection:(NSURLConnection*) connection
{
    BOOL success = YES;
    
    if (!_dataRecieved)
    {
        _dataRecieved = [[NSMutableData alloc] init];
    }
    
    if (connection == self.getBooksConnection)
    {
        self.getBooksConnection = [LibraryServerCommunicator sendRequestToURL:url withDelegate:self ];
    }
    else if (connection == self.detailedBooksConnection)
    {
        self.detailedBooksConnection = [LibraryServerCommunicator sendRequestToURL:url withDelegate:self];
    }
    if (!success)
    {
        _dataRecieved = nil;
    }
    
}


#pragma mark NSURLConnectionDelegate, NSURLConnectionDataDelegate protocols implementation



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    _dataRecieved = nil;
    _dataRecieved = [data mutableCopy];
    
    NSLog(@"Did receive data");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Did finish loading - start");
    if (connection == self.getBooksConnection)
    {
//        LibraryOperation* op = [[LibraryOperation alloc] initWithData:self.dataRecieved manager:self];
        [self.operationQueue addOperation:self.getBooksListOperation];
    }
    else if (connection == self.detailedBooksConnection)
    {
        LibrarySingleBookOperation* op = [[LibrarySingleBookOperation alloc] initWithData:self.dataRecieved manager:[LibraryManager sharedManager]];
        [self.operationQueue addOperation:op];
    }
    NSLog(@"Did finish loading - finish");
}
-(NSArray*) fetchBooksFromDB
{
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext* context = [(LibraryAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Book"
                                                         inManagedObjectContext:context];
    [request setEntity:entityDescription];
    NSError* err = nil;
    NSArray* fetchedObjects = [context executeFetchRequest:request error:&err];
    return fetchedObjects;
}

-(void) transfromFetchedObjectsToBooks:(NSArray*) fetchedObjects
{
    NSMutableArray* booksMutableArray = [[NSMutableArray alloc] init];
    for (NSManagedObject* bookObject in fetchedObjects) {
        [booksMutableArray addObject: [LibraryBookCreator singleBookFromNSManagedObject:bookObject ]];
    }
    self.books = booksMutableArray;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];

}
-(void) loadFromDB
{
    NSArray* fetchedObjects = [self fetchBooksFromDB];
    [self transfromFetchedObjectsToBooks:fetchedObjects];
    
//    NSFetchRequest* request = [[NSFetchRequest alloc] init];
//    NSManagedObjectContext* context = [(LibraryAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
//    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Book"
//                                                         inManagedObjectContext:context];
//    [request setEntity:entityDescription];
//    NSError* err = nil;
//    NSArray* fetchedObjects = [context executeFetchRequest:request error:&err];
//    
//    NSMutableArray* booksMutableArray = [[NSMutableArray alloc] init];
//    for (NSManagedObject* bookObject in fetchedObjects) {
//        [booksMutableArray addObject: [LibraryBookCreator singleBookFromNSManagedObject:bookObject ]];
//    }
//    self.books = booksMutableArray;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //load list of books from local DB
    if (connection == self.getBooksConnection)
    {
        [self loadFromDB];
    }
    else if (connection == self.detailedBooksConnection)
    {
        //load detailed book description from local DB
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
    
    NSLog(@"Did finish loading");
}
@end
