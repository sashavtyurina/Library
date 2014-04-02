//
//  UIImageView+Cache.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 02/04/14.
//
//

#import "UIImageView+Cache.h"
static const void *LibraryImageViewOperationAssociationKey = &LibraryImageViewOperationAssociationKey;

@implementation UIImageView (Cache)

- (void)setImageWithURL:(NSString *)imageURL {
    
    void(^assignResultPictureBlock)(UIImage *) = ^(UIImage * coverImage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = coverImage;
        });
    };
    
    LibraryDownloadImageOperation *oldOperation = objc_getAssociatedObject(self, LibraryImageViewOperationAssociationKey);
    [oldOperation cancel];
    
    objc_setAssociatedObject(self, LibraryImageViewOperationAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    LibraryDownloadImageOperation *newOperation = [[LibraryDownloadImageOperation alloc] initWithImageURL:imageURL completionBlock:assignResultPictureBlock];

    objc_setAssociatedObject(self, LibraryImageViewOperationAssociationKey, newOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:newOperation];

}

@end
