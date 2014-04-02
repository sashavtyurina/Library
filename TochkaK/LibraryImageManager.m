//
//  LibraryImageManager.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 01/04/14.
//
//

#import "LibraryImageManager.h"
static const void *LibraryImageViewOperationAssociationKey = &LibraryImageViewOperationAssociationKey;

@interface LibraryImageManager ()

@property (strong, nonatomic) NSMutableDictionary *coverImagesAndOperations;

@end

@implementation LibraryImageManager

- (NSMutableDictionary *)coverImagesAndOperations {
    if (!_coverImagesAndOperations) {
        _coverImagesAndOperations = [[NSMutableDictionary alloc] init];
    }
    return _coverImagesAndOperations;
}

+ (instancetype)sharedManager {
    static LibraryImageManager *sharedLibraryManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLibraryManager = [[self alloc] init];
    });
    return sharedLibraryManager;
}

- (void)startProcessingImageView:(UIImageView *)imageView withURL:(NSString *)imageURL {
    
    LibraryDownloadImageOperation *oldOperation = objc_getAssociatedObject(imageView, LibraryImageViewOperationAssociationKey);
    [oldOperation cancel];
    objc_setAssociatedObject(imageView, LibraryImageViewOperationAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    LibraryDownloadImageOperation *newOperation = [[LibraryDownloadImageOperation alloc] initWithImageURL:imageURL imageView:imageView];
//    
//    objc_setAssociatedObject(imageView, LibraryImageViewOperationAssociationKey, newOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:newOperation];
    
    
}
@end
