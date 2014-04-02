//
//  LibraryDownloadImageOperation.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 01/04/14.
//
//
typedef void(^AssignResultPictureBlock)(UIImage *);
#import <Foundation/Foundation.h>
#import "NSString+MD5Hash.h"

@interface LibraryDownloadImageOperation : NSOperation

- (id)initWithImageURL:(NSString *)imageURL completionBlock:(AssignResultPictureBlock)assignResultPicture;

@end
