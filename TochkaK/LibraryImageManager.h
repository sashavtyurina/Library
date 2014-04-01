//
//  LibraryImageManager.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 01/04/14.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "LibraryDownloadImageOperation.h"
#import "LibraryConstants.h"


@interface LibraryImageManager : NSObject
+ (instancetype)sharedManager;

- (void)startProcessingImageView:(UIImageView *)imageView withURL:(NSString *)imageURL;
@end
