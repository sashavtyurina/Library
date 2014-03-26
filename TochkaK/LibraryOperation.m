//
//  LibraryOperation.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 24/03/14.
//
//

#import "LibraryOperation.h"
#import "LibraryServerCommunicator.h"

@interface LibraryOperation()

@property (strong, nonatomic) LibraryManager *manager;
@property (strong, nonatomic) NSURL *url;

//get every book from the local chached DB
- (NSArray *)fetchBooksFromDB;

//transforms objects fetched from DB to NSArray of Books
- (void)transfromFetchedObjectsToBooks:(NSArray *)fetchedObjects;

//crates a cached copy of the data recieved from the server
- (void)backupDBFromServer;

@end

@implementation LibraryOperation

- (id)initWithURL:(NSURL *)url manager:(LibraryManager *)manager {
    self = [super init];
    if (self) {
        self.manager = manager;
        self.url = url;
        
    }
    return  self;
}

- (NSArray *)fetchBooksFromDB {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [(LibraryAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Book"
                                                         inManagedObjectContext:context];
    [request setEntity:entityDescription];
    NSError *err = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&err];
    return fetchedObjects;
}

- (void)transfromFetchedObjectsToBooks:(NSArray *)fetchedObjects {
    NSMutableArray *booksMutableArray = [[NSMutableArray alloc] init];
    for (NSManagedObject *bookObject in fetchedObjects) {
        [booksMutableArray addObject: [LibraryBookCreator singleBookFromNSManagedObject:bookObject ]];
    }
    self.manager.books = booksMutableArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];
    });
}

- (void)backupDBFromServer {

    LibraryAppDelegate *appDelegate = (LibraryAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //save the essential information about each book in the local storage
    for (LibraryBook *book in self.manager.books) {
        NSManagedObject *bookObject = [NSEntityDescription insertNewObjectForEntityForName:@"Book"
                                                                    inManagedObjectContext:context];
        [bookObject setValue:[NSNumber numberWithInt:book.ID] forKey:@"bookID"];
        [bookObject setValue:book.title forKey:@"title"];
        [bookObject setValue:book.authorTitle forKey:@"authorTitle"];
        [bookObject setValue:[NSNumber numberWithBool:book.free] forKey:@"free"];
        NSData *img = nil; //[NSData dataWithContentsOfURL:[NSURL URLWithString:book.url]];
        [bookObject setValue:img forKey:@"image"];
    }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

- (void)main {
    //got data in the DB?
    NSArray *fetchedObjects = [self fetchBooksFromDB];
    if ([fetchedObjects count] != 0) {
        //get data from the database
        [self transfromFetchedObjectsToBooks:fetchedObjects];
    } else {
        //get data from the server
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.url];
        NSURLResponse *response = nil;
        NSError *err = nil;
        NSData *requestResult = [NSURLConnection sendSynchronousRequest:request
                                                      returningResponse:&response
                                                                  error:&err];

        //check if the data retrieved is nil
        if (! [requestResult isEqual:nil]) {
            self.manager.books = [LibraryBookCreator booksFromJSON:requestResult error:&err];
            //save the loaded data to the DB
            [self backupDBFromServer];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"BOOKS_RETRIEVED" object:nil];
            });
        } else {
            NSLog(@"no connection, no cached version. Operation failed.");
        }
    }
}

@end
