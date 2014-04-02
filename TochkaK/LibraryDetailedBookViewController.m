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
@property (weak, nonatomic) IBOutlet LibraryCustomizedDetailedView *detailedCustomView;

@end

@implementation LibraryDetailedBookViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#warning bug1
//viewDidLoad is called after updateUI
- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self isMovingFromParentViewController]) {
        [self clearContents];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)clearContents {
    self.titleLabelOutlet.text = @"";
    self.authorLabelOutlet.text = @"";
    self.subtitleLabelOutlet.text = @"";
    self.freeLabelOutlet.text = @"";
    self.descriptionLabelOutlet.text = @"";
    self.coverImageOutlet.image = nil;
    [self.scrollViewOutlet setContentOffset:CGPointMake(0, 0)];
}

- (void)updateUI {
    NSLog(@"DetailedViewController updated");
    self.titleLabelOutlet.text = self.bookToShow.title;
    self.subtitleLabelOutlet.text = self.bookToShow.subTitle;
    self.authorLabelOutlet.text = self.bookToShow.authorTitle;
    self.descriptionLabelOutlet.text = self.bookToShow.description;
    self.freeLabelOutlet.text = self.bookToShow.free ? @"free" : @"$$$";
    
    [self.coverImageOutlet startLoadingImageFromURL:self.bookToShow.url];
 
    //let that gray view on the top resize itself
    [self.detailedCustomView invalidateIntrinsicContentSize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
