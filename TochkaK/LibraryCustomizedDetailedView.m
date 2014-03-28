//
//  LibraryCustomizedDetailedView.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 28/03/14.
//
//

#import "LibraryCustomizedDetailedView.h"
@interface LibraryCustomizedDetailedView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *authorLabelOutlet;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalSpaceTitleToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalSpaceSubtitleToTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalSpaceAuthorToSubtitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalSpacebottomToAuthor;


@end
@implementation LibraryCustomizedDetailedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGSize)intrinsicContentSize {

    CGFloat titleHeight = self.titleLabelOutlet.intrinsicContentSize.height;
    CGFloat subtitleHeight = self.subtitleLabelOutlet.intrinsicContentSize.height;
    CGFloat authorHeight = self.authorLabelOutlet.intrinsicContentSize.height;
    CGFloat additionalVerticalSpace = [self getAdditionalVerticalSpace];
    CGFloat newHeight = additionalVerticalSpace + titleHeight + subtitleHeight + authorHeight;
    
    CGFloat oldHeight = self.frame.size.height;
    
    newHeight = newHeight > oldHeight ? newHeight : oldHeight;
    
    return CGSizeMake(self.frame.size.width, newHeight);
}

- (CGFloat) getAdditionalVerticalSpace {
    return self.verticalSpaceTitleToTop.constant + self.verticalSpaceSubtitleToTitle.constant + self.verticalSpaceAuthorToSubtitle.constant + self.verticalSpacebottomToAuthor.constant;
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
