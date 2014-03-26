//
//  LibraryOperation.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 24/03/14.
//
//

#import <Foundation/Foundation.h>
#import "LibraryManager.h"

@interface LibraryOperation : NSOperation
- (id)initWithURL:(NSURL *)url manager:(LibraryManager *)manager;
@end
