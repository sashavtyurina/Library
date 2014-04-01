//
//  LibraryDownloadImageOperation.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 01/04/14.
//
//

#import "LibraryDownloadImageOperation.h"
@interface LibraryDownloadImageOperation ()

@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) NSString *filePath;

@end

@implementation LibraryDownloadImageOperation
- (instancetype)initWithImageURL:(NSString *)imageURL imageView:(UIImageView *)imageView{
    self = [super init];
    if (self) {
        self.imageURL = imageURL;
        self.imageView = imageView;
    }
    return self;
}

- (BOOL)imageExistsLocally {
    NSString *hashedFileName = [self.imageURL  MD5String];
    //
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    self.filePath = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", hashedFileName]];
    ////        NSLog(@"Hashed name: %@; Title: %@", filePath, bookPresenting.title);
    return [fileManager fileExistsAtPath:self.filePath];
}

- (NSData *)loadImageFromDisk {
    return [NSData dataWithContentsOfFile:self.filePath];
}

- (NSData *)loadImageFromServer {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.imageURL]];
    NSURLResponse *response = nil;
    NSError *err = nil;
    NSData* imageData = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:&response
                                                          error:&err];
    return imageData;
}

- (BOOL)saveImageToDisk:(NSData *)imageData {
    BOOL fileCreated = [[NSFileManager defaultManager] createFileAtPath:self.filePath contents:imageData attributes:nil];
    return fileCreated;
}

- (void)main {
    
    NSData *imageData = nil;
    
    //check if the image is already downloaded
    if ([self imageExistsLocally]) {
        imageData = [self loadImageFromDisk];
        NSLog(@"Image loaded from disk");
    } else {
    //if not download it from the server
        NSLog(@"Image loaded from server");
        imageData = [self loadImageFromServer];
        [self saveImageToDisk:imageData];
    }
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    if (![self isCancelled]) {
        
//        NSLog(@"not cancelled");
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    } else {
//        NSLog(@"is cancelled");
    }
    
}

- (void)cancel {
    //what do we do on cancel?
//    NSLog(@"cancelled"); 
    [super cancel];
    self.imageView.image = nil;
    self.imageURL = nil;
}
@end
