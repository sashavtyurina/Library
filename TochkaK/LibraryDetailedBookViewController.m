//
//  LibraryDetailedBookViewController.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 09/03/14.
//
//

#import "LibraryDetailedBookViewController.h"

@interface LibraryDetailedBookViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *authorLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *publishedLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *freeLabelOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabelOutlet;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewOutlet;
@property (weak, nonatomic) IBOutlet LibraryDetailedView *detailedCustomView;

//constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalSpaceTitleToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalSpaceSubtitleToTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalSpaceAuthorToSubtitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalSpacebottomToAuthor;

@end

@implementation LibraryDetailedBookViewController

- (CGFloat) getAdditionalVerticalSpace {
    return self.verticalSpaceTitleToTop.constant + self.verticalSpaceSubtitleToTitle.constant + self.verticalSpaceAuthorToSubtitle.constant + self.verticalSpacebottomToAuthor.constant;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void)viewDidDisappear:(BOOL)animated {
    self.titleLabelOutlet.text = @"";
    self.authorLabelOutlet.text = @"";
    self.subtitleLabelOutlet.text = @"";
    self.freeLabelOutlet.text = @"";
    self.descriptionLabelOutlet.text = @"";
    self.coverImageOutlet.image = nil;
    [self.scrollViewOutlet setContentOffset:CGPointMake(0, 0)];
}

- (void)updateUI {
    self.titleLabelOutlet.text = self.bookToShow.title;
    self.subtitleLabelOutlet.text = self.bookToShow.subTitle;
    self.authorLabelOutlet.text = self.bookToShow.authorTitle;
    self.descriptionLabelOutlet.text = self.bookToShow.description;
    self.freeLabelOutlet.text = self.bookToShow.free ? @"free" : @"$$$";
    if (self.bookToShow.image == nil) {
        self.coverImageOutlet.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.bookToShow.url]]];
    } else {
        self.coverImageOutlet.image = [UIImage imageWithData:self.bookToShow.image];
    }
    
    [self resizeCustomDetailedView];
}

- (void)resizeCustomDetailedView {
    CGFloat titleHeight = self.titleLabelOutlet.intrinsicContentSize.height;
    CGFloat subtitleHeight = self.subtitleLabelOutlet.intrinsicContentSize.height;
    CGFloat authorHeight = self.authorLabelOutlet.intrinsicContentSize.height;
    CGFloat additionalVerticalSpace = [self getAdditionalVerticalSpace];

    CGFloat newHeight = additionalVerticalSpace +  titleHeight + subtitleHeight + authorHeight;
    
    //if the new height is greater then the old one we update it
    if (newHeight > self.customViewHeightConstraint.constant) {
        self.customViewHeightConstraint.constant = newHeight;
        NSLog(@"new height: %f", newHeight);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
