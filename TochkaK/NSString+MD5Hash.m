//
//  NSString+MD5Hash.m
//  Aggregator
//
//  Created by Andrew Vyazovoy on 10.01.13.
//  Copyright (c) 2013 Applifto Inc. All rights reserved.
//

#import "NSString+MD5Hash.h"

#include <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5Hash)

- (NSString *)MD5String {
    const char *cString = [self cStringUsingEncoding:NSUTF8StringEncoding];
	
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cString, strlen(cString), digest);
	
	NSMutableString *digestString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSUInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digestString appendFormat:@"%02x", digest[i]];
    }
	return [NSString stringWithString:digestString];
}

@end
