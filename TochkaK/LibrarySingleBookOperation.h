//
//  LibrarySingleBookOperation.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 24/03/14.
//
//

#import <Foundation/Foundation.h>
#import "LibraryManager.h"
@interface LibrarySingleBookOperation : NSOperation
-(id) initWithData:(NSData*) data manager:(LibraryManager*) manager;
@end
