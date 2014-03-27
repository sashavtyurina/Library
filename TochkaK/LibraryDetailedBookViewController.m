//
//  LibraryDetailedBookViewController.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 09/03/14.
//
//

#import "LibraryDetailedBookViewController.h"

@interface LibraryDetailedBookViewController ()
//@property (strong, nonatomic) UILabel *titleLabel;
//@property (strong, nonatomic) UILabel *authorTitleLabel;
//@property (strong, nonatomic) UIImageView *coverImage;
//@property (strong, nonatomic) UILabel *descriptionLabel;
//@property (strong, nonatomic) UILabel *subtitleLable;
//@property (strong, nonatomic) UILabel *publishedLabel;
//@property (strong, nonatomic) UILabel *freeLabel;
//@property (strong, nonatomic) UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *authorLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *publishedLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *freeLabelOutlet;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabelOutlet;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewOutlet;
@property (weak, nonatomic) IBOutlet LibraryDetailedView *detailedCustomView;

@end

@implementation LibraryDetailedBookViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        NSLog(@"Initializing with bundle");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void)viewDidDisappear:(BOOL)animated {
//    self.titleLabelOutlet.text = @"";
//    self.authorLabelOutlet.text = @"";
//    self.subtitleLabelOutlet.text = @"";
//    self.freeLabelOutlet.text = @"";
//    self.descriptionLabelOutlet.text = @"";
//    self.coverImageOutlet.image = nil;
//    [self.scrollViewOutlet setContentOffset:CGPointMake(0, 0)];
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
//    [self.detailedCustomView sizerToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
