//
//  LibraryDownloadImageOperation.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 01/04/14.
//
//

#import <Foundation/Foundation.h>
#import "NSString+MD5Hash.h"

@interface LibraryDownloadImageOperation : NSOperation

- (id)initWithImageURL:(NSString *)imageURL imageView:(UIImageView *)imageView;

@end
