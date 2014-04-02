//
//  LibraryCommunicator.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 08/03/14.
//
//

#import "LibraryManager.h"
#import "LibraryBookCreator.h"
#import "LibraryOperation.h"
#import "LibrarySingleBookOperation.h"

@interface LibraryManager ()
@property (strong, nonatomic) NSURL *sourceURL;

//URLConnection
@property (strong, nonatomic) NSMutableData *dataRecieved;
@property (strong, nonatomic) NSURLConnection *getBooksConnection;
@property (strong, nonatomic) NSURLConnection *detailedBooksConnection;
@property NSInteger requstedBookID;

//utility methods
@property (strong, nonatomic) NSOperationQueue *operationQueue;
@property (strong, nonatomic) LibrarySingleBookOperation *getSingleBookOperation;

//constructs URL that contains detailed info about the book with ID
- (NSURL *)constructURLForBookWithID:(NSInteger)ID;

@end

@implementation LibraryManager

+ (instancetype)sharedManager {
    static LibraryManager *sharedLibraryManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLibraryManager = [[self alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:sharedLibraryManager
                                                 selector:@selector(saveRequestedBookDetails)
                                                     name:BookDetailsRetrievedFromServer
                                                   object:nil];
    });
    return sharedLibraryManager;
}

- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        [_operationQueue setMaxConcurrentOperationCount:1];
    }
    return  _operationQueue;
}

- (LibraryManager *)init {
    self = [super init];
    //do we need custom initialization here?
    return  self;
}

//Manage List of Books
- (void)requestBooksList {
    LibraryOperation *operation = [[LibraryOperation alloc] initWithURL:[NSURL URLWithString:@"http://test.tochkak.ru/list.json"]
                                                                manager:[LibraryManager sharedManager]];
    [[[LibraryManager sharedManager] operationQueue] addOperation:operation];
}

//Manage Detailed Description of Single Book
- (void)requestDetailedBookWithID:(NSInteger)requestedBookID {
    [[LibraryManager sharedManager] setRequstedBookID:requestedBookID];
    NSArray *requestedBook = [self fetchBookWithIDFromDB:requestedBookID];
    
    if ([requestedBook count] != 0) {
        LibraryBook *b = [LibraryBookCreator singleBookFromNSManagedObject:[requestedBook lastObject]];
        
        //is this record full or does it need completion?
        BOOL subtitleIsEmpty = b.subTitle == nil;
        BOOL publishedIsEmpty = b.published == nil;
        BOOL descriptionIsEmpty = b.description == nil;

        //if the book details are full
        if (!(subtitleIsEmpty || publishedIsEmpty || descriptionIsEmpty)) {
            [[LibraryManager sharedManager] setRequestedBook:b];
            [[NSNotificationCenter defaultCenter] postNotificationName:BookDetailsIsReadyToBePresented object:nil];
        } else {
            LibrarySingleBookOperation *operation = [[LibrarySingleBookOperation alloc] initWithBookID:requestedBookID];
            [[[LibraryManager sharedManager] operationQueue] addOperation:operation];
        }
    }
}

- (void) saveRequestedBookDetails {

    NSArray *requestedBook = [self fetchBookWithIDFromDB:[[LibraryManager sharedManager] requstedBookID]];
    LibraryBook *b = [LibraryBookCreator singleBookFromNSManagedObject:[requestedBook lastObject]];
    [[LibraryManager sharedManager] setRequestedBook:b];
    //post notification for VC
    [[NSNotificationCenter defaultCenter] postNotificationName:BookDetailsIsReadyToBePresented object:nil];
}

- (LibraryBook *)saveRequestedLibraryBook:(LibraryBook *)requestedLibraryBook {
    [[LibraryManager sharedManager] setRequestedBook:requestedLibraryBook];
    [[NSNotificationCenter defaultCenter] postNotificationName:BookDetailsRetrieved object:nil];
    return requestedLibraryBook;
}

- (NSArray *)fetchBookWithIDFromDB:(NSInteger)bookID {
    //check if this book is in the DB
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [(LibraryAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Book"
                                                         inManagedObjectContext:context];
    [request setEntity:entityDescription];
    NSError *err = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bookID = %d ", bookID];
    request.predicate = predicate;
    NSArray *requstedBook = [context executeFetchRequest:request error:&err];
    return requstedBook;
}

- (NSURL *)constructURLForBookWithID:(NSInteger)ID {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://test.tochkak.ru/item.json?id=%d", ID]];
}

@end
