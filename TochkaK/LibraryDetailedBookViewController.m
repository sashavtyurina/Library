//
//  LibraryDetailedBookViewController.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 09/03/14.
//
//

#import "LibraryDetailedBookViewController.h"

@interface LibraryDetailedBookViewController ()
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* authorTitleLabel;
@property (strong, nonatomic) UIImageView* coverImage;
@end

@implementation LibraryDetailedBookViewController
@synthesize titleLabel = _titleLabel;
@synthesize authorTitleLabel = _authorTitleLabel;
@synthesize coverImage = _coverImage;
- (UIImageView *)coverImage
{
    if (!_coverImage)
    {
        _coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(250, 40, 50, 50)];
    }
    return _coverImage;
}

-(UILabel*) titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 300, 50)];
    }
    return _titleLabel;
}

-(UILabel*) authorTitleLabel
{
    if (!_authorTitleLabel)
    {
        _authorTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 90, 300, 50)];
    }
    return _authorTitleLabel;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGPoint p = self.view.bounds.origin;
    CGSize s = self.view.bounds.size;
    self.view.backgroundColor = [UIColor whiteColor];
    
	// Do any additional setup after loading the view.
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont fontWithName:@"Courier" size:30];
    
    self.titleLabel.text = self.bookToShow.title;
    self.authorTitleLabel.text = self.bookToShow.authorTitle;
    
    self.coverImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.bookToShow.url]]];
    
    [self.view addSubview:self.coverImage];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.authorTitleLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
