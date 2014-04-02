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

@property (nonatomic, copy) AssignResultPictureBlock assignResultPicture;

@end

@implementation LibraryDownloadImageOperation

- (instancetype)initWithImageURL:(NSString *)imageURL completionBlock:(AssignResultPictureBlock)assignResultPicture {
    self = [super init];
    
    if (self) {
        self.imageURL = imageURL;
        self.assignResultPicture = assignResultPicture;
    }
    return self;
}

- (void)main {
    
    NSData *imageData = nil;
    
    //check if the image is already downloaded
    if ([self imageExistsLocally]) {
        imageData = [self loadImageFromDisk];
    } else {
        imageData = [self loadImageFromServer];
        [self saveImageToDisk:imageData];
    }
    UIImage *resultImage = [UIImage imageWithData:imageData];
    
    if (![self isCancelled]) {
        self.assignResultPicture(resultImage);
    }
}

- (BOOL)imageExistsLocally {
    NSString *hashedFileName = [self.imageURL  MD5String];
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



- (void)cancel {
    //what do we do on cancel?
//    NSLog(@"cancelled"); 
    [super cancel];
    self.imageView.image = nil;
    self.imageURL = nil;
}
@end
