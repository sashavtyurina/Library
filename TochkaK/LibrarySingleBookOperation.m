//
//  LibrarySingleBookOperation.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 24/03/14.
//
//

#import "LibrarySingleBookOperation.h"
#import "LibraryBookCreator.h"
@interface LibrarySingleBookOperation()

@property (strong, nonatomic) LibraryManager* manager;
@property (assign, nonatomic) int requestedBookID;

-(NSURL*) constructURLForBookWithID:(NSInteger) ID ;

@end
@implementation LibrarySingleBookOperation

-(id) initWithBookID:(int) requestedBookID manager:(LibraryManager*) manager{
    self = [super init];
    if (self){
        self.requestedBookID = requestedBookID;
        self.manager = manager;
    }
    return self;
}

-(NSURL*) constructURLForBookWithID:(NSInteger) ID {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://test.tochkak.ru/item.json?id=%d", ID]];
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
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"bookID = %d ", self.requestedBookID];
    [request setPredicate:predicate];
    NSArray* requstedBook = [context executeFetchRequest:request error:&err];
    return requstedBook;
    
}

-(void) main {
    
    //retrieve the requested book from the server
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[self constructURLForBookWithID:self.requestedBookID]];
    NSURLResponse* response = nil;
    NSError* err = nil;
    NSData* requestResult = [NSURLConnection sendSynchronousRequest:request
                                                  returningResponse:&response
                                                              error:&err];
    if (![requestResult isEqual:nil])
    {
        //parse the book
        //save it as a property
        NSError* err = nil;
        self.requestedBook = [LibraryBookCreator singleBookFromJSON:requestResult error:&err];

        self.manager.requestedBook = self.requestedBook;
        
        //save new data to local DB
        NSArray* bookToBeComplemented = [self fetchBookWithIDFromDB:self.requestedBookID];
        NSManagedObject* bookObject = [bookToBeComplemented lastObject];
        
        [bookObject setValue:self.requestedBook.subTitle forKey:@"subtitle"];
        [bookObject setValue:self.requestedBook.published forKey:@"published"];
        [bookObject setValue:self.requestedBook.description forKey:@"bookdescription"];
        
        NSError *error;
        NSManagedObjectContext* context = [(LibraryAppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        //post notification
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:BookDetailsRetrieved object:nil];
        });
        

    }
}
@end
