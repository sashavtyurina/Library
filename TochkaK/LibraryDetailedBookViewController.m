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
@property (strong, nonatomic) UILabel* descriptionLabel;
@property (strong, nonatomic) UILabel* subtitleLable;
@property (strong, nonatomic) UILabel* publishedLabel;
@property (strong, nonatomic) UILabel* freeLabel;

@property (strong, nonatomic) UIScrollView* scrollView;
@end

@implementation LibraryDetailedBookViewController
@synthesize titleLabel = _titleLabel;
@synthesize authorTitleLabel = _authorTitleLabel;
@synthesize coverImage = _coverImage;
@synthesize bookToShow = _bookToShow;

-(UILabel*) titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 240, 25)];
    }
    return _titleLabel;
}


-(UILabel*) subtitleLable
{
    if (!_subtitleLable)
    {
        _subtitleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 240, 25)];
    }
    return _subtitleLable;
}

-(UILabel*) authorTitleLabel
{
    if (!_authorTitleLabel)
    {
        _authorTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 300, 25)];
    }
    return _authorTitleLabel;
}

-(UILabel*) publishedLabel
{
    if (!_publishedLabel)
    {
        _publishedLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 300, 25)];
    }
    return  _publishedLabel;
}

-(UILabel*) freeLabel
{
    if (!_freeLabel)
    {
        _freeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 300, 25)];
    }
    return  _freeLabel;
}

-(UILabel*) descriptionLabel
{
    if (!_descriptionLabel)
    {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 300, 75)];
    }
    return _descriptionLabel;
}

-(LibraryBook*) bookToShow
{
    if (!_bookToShow)
    {
        _bookToShow = [[LibraryBook alloc] init];
    }
    return _bookToShow;
}

- (UIImageView *)coverImage
{
    if (!_coverImage)
    {
        _coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(250, 40, 50, 50)];
    }
    return _coverImage;
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
	// Do any additional setup after loading the view.
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont fontWithName:@"Courier" size:24];
    self.titleLabel.text = @"";
    
    self.subtitleLable.textColor = [UIColor blackColor];
    self.subtitleLable.font = [UIFont fontWithName:@"Courier" size:20];
    self.subtitleLable.text = @"";
    
    self.authorTitleLabel.textColor = [UIColor grayColor];
    self.authorTitleLabel.font = [UIFont fontWithName:@"Courier" size:20];
    self.authorTitleLabel.text = @"";
    
    self.publishedLabel.textColor = [UIColor grayColor];
    self.publishedLabel.font = [UIFont fontWithName:@"Courier" size:20];
    self.publishedLabel.text = @"";
    
    self.freeLabel.textColor = [UIColor grayColor];
    self.freeLabel.font = [UIFont fontWithName:@"Courier" size:20];
    self.freeLabel.text = @"";
    
    self.descriptionLabel.text = @"Description: ";
    self.descriptionLabel.textColor = [UIColor blackColor];
    self.descriptionLabel.font = [UIFont fontWithName:@"Courier" size:18];
    self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.descriptionLabel.numberOfLines = 0;

    self.coverImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.bookToShow.url]]];
    [self.scrollView addSubview:self.coverImage];

    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.subtitleLable];
    [self.scrollView addSubview:self.authorTitleLabel];
    [self.scrollView addSubview:self.publishedLabel];
    [self.scrollView addSubview:self.freeLabel];
    [self.scrollView addSubview:self.descriptionLabel];
}

-(void) updateUI
{
    self.titleLabel.text = self.bookToShow.title;
    self.authorTitleLabel.text = self.bookToShow.authorTitle;
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@: %@", @"Description", self.bookToShow.description];
    self.subtitleLable.text = self.bookToShow.subTitle;
    self.freeLabel.text = self.bookToShow.free ? @"Бесплатная": @"Платная";
    self.publishedLabel.text = self.bookToShow.published;
    
    self.coverImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.bookToShow.url]]];
    
    [self.descriptionLabel sizeToFit];
    [self.titleLabel sizeToFit];
    [self.authorTitleLabel sizeToFit];
    [self.subtitleLable sizeToFit];
    [self.freeLabel sizeToFit];
    [self.publishedLabel sizeToFit];
    
    self.scrollView.contentSize =  CGSizeMake(320, self.titleLabel.frame.size.height+ self.authorTitleLabel.frame.size.height + self.descriptionLabel.frame.size.height + 50);
}

-(void) upd
{
    self.titleLabel.text = self.bookToShow.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
