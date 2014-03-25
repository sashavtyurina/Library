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
@property (strong, nonatomic) LibrarySingleBookOperation* getSingleBookOperation;
//@property (strong, nonatomic) LibrarySingleBookOperation*
//@property (strong, nonatomic) LibraryOperation* getBooksListOperation;

//copies detailed info about the book into a local storage
//-(void) copyBookToDB: (LibraryBook*) book;

//constructs URL that contains detailed info about the book with ID
-(NSURL*) constructURLForBookWithID:(NSInteger) ID;

@end



@implementation LibraryManager

-(NSOperationQueue*) operationQueue
{
    if (!_operationQueue)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        [_operationQueue setMaxConcurrentOperationCount:1];
    }
    return  _operationQueue;
}

+(id) sharedManager
{
    static LibraryManager *sharedLibraryManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLibraryManager = [[self alloc] init];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(makeCopyOfRequestedBook)
//                                                     name:BookDetailsRetrievedFromServer
//                                                   object:nil];

        
    });
    return sharedLibraryManager;
}

-(void) makeCopyOfRequestedBook
{
    [[LibraryManager sharedManager] setRequestedBook: [[[LibraryManager sharedManager] getSingleBookOperation] requestedBook]];
    [[NSNotificationCenter defaultCenter] postNotificationName:BookDetailsRetrieved object:nil];
    
}
-(LibraryManager*) init{
    self = [super init];
    //do we need custom initialization here?
    return  self;
}

//get list of books
-(void) startGettingBooks {
    LibraryOperation* operation = [[LibraryOperation alloc] initWithURL:[NSURL URLWithString:@"http://test.tochkak.ru/list.json"]
                                                                manager:[LibraryManager sharedManager]];
    [[[LibraryManager sharedManager] operationQueue] addOperation:operation];
}


//get a single book
-(void) startGettingDetailedDescriptionOfBookWithID:(NSInteger)requestedBookID {
    
    NSArray* requestedBook = [self fetchBookWithIDFromDB:requestedBookID];
    //we found smth in the database
    if ([requestedBook count] != 0)
    {
        LibraryBook* b = [LibraryBookCreator singleBookFromNSManagedObject:[requestedBook lastObject]];
        //is this record full or does it need completion?
        //if the book details are full
        NSLog(@"%@", b.subTitle);
        BOOL subtitleIsEmpty = b.subTitle == nil;
        BOOL publishedIsEmpty = b.published == nil;
        BOOL descriptionIsEmpty = b.description == nil;
        if (!( subtitleIsEmpty || publishedIsEmpty || descriptionIsEmpty))
        {
            [[LibraryManager sharedManager] setRequestedBook:b];
            [[NSNotificationCenter defaultCenter] postNotificationName:BookDetailsRetrieved object:nil];
        }
        else
        //get requested book from the server
        {
            LibrarySingleBookOperation* operation = [[LibrarySingleBookOperation alloc] initWithBookID:requestedBookID
                                                                                                            manager:[LibraryManager sharedManager]];
          //  [[LibraryManager sharedManager] setGetSingleBookOperation: [[[LibraryManager sharedManager] getSingleBookOperation] initWithBookID:requestedBookID manager:[LibraryManager sharedManager]]];
            [[[LibraryManager sharedManager] operationQueue] addOperation:operation];
        }
    }
}

-(NSArray*) fetchBookWithIDFromDB:(NSInteger) bookID
{
    //check if this book is in the DB
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext* context = [(LibraryAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Book"
                                                         inManagedObjectContext:context];
    [request setEntity:entityDescription];
    NSError* err = nil;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"bookID = %d ", bookID];
    [request setPredicate:predicate];
    NSArray* requstedBook = [context executeFetchRequest:request error:&err];
    return requstedBook;
}

-(NSURL*) constructURLForBookWithID:(NSInteger) ID
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://test.tochkak.ru/item.json?id=%d", ID]];
}

//-(void) copyBookToDB: (LibraryBook*) book
//{
//    book = self.requestedBook; // initial value is not passed. why?
//    LibraryAppDelegate* appDelegate = (LibraryAppDelegate*)[[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext* context = [appDelegate managedObjectContext];
//    
//    NSFetchRequest* request = [[NSFetchRequest alloc] init];
//    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Book"
//                                                         inManagedObjectContext:context];
//    [request setEntity:entityDescription];
//    NSError* err = nil;
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"bookID = %d ", book.ID];
//    [request setPredicate:predicate];
//    NSArray* requstedBook = [context executeFetchRequest:request error:&err];
//    
//    if (!([requstedBook lastObject] == nil))
//    {
//        //complement the book in the local storage with the details
//        NSManagedObject* bookObject = [requstedBook lastObject];
//        NSString* subtitle = [bookObject valueForKey:@"subtitle"];
//        if (subtitle == nil)
//        {
//            [bookObject setValue:book.subTitle forKey:@"subtitle"];
//            [bookObject setValue:book.published forKey:@"published"];
//            [bookObject setValue:book.description forKey:@"bookdescription"];
//            
//            NSError *error;
//            if (![context save:&error]) {
//                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//            }
//        }
//    }
//
//}

@end
