//
//  UIImageView+Cache.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 02/04/14.
//
//


#import <UIKit/UIKit.h>
#import "LibraryDownloadImageOperation.h"
#import <objc/runtime.h>
#import "LibraryConstants.h"
#import <Foundation/Foundation.h>

@interface UIImageView (Cache)
- (void)startLoadingImageFromURL:(NSString *)imageURL;
@end
