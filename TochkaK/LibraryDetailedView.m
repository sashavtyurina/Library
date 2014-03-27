//
//  LibraryDetailedView.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 27/03/14.
//
//

#import "LibraryDetailedView.h"

@implementation LibraryDetailedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    NSLog(@"intrinsic size");
    return CGSizeMake(200, 200);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
