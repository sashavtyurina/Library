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
 
    //let that gray view on the top resize itself
    [self.detailedCustomView invalidateIntrinsicContentSize];
    
#warning testing blocks, cleanup afterwards
    
    
    __block NSMutableArray *test__blockMutableArray = [NSMutableArray arrayWithArray: @[@YES, @2, @"three"]];
    NSMutableArray *testMutableArray = [NSMutableArray arrayWithArray: @[@NO, @1, @"two"]];
    
    int x = 123;
    
    void (^myTestBlock)(int, int) = ^(int l, int r) {
//        NSLog(@"My test block result is: %i", l*r);
//        NSLog(@"Also try to use local variables: %@", self.titleLabelOutlet.text);
//        [self testFunction];
        
#warning why are both of the arrays changing?
        
//        //local to the enclosing scope variables are captured as const and so are immutable
//        [test__blockMutableArray addObject:@"four"];
//        NSLog(@"Mutated __block version:%@", test__blockMutableArray);
//        
//        //variables local to the enclosing scope and declared with __block are provided by reference and so are mutable
//        [testMutableArray addObject:@"three"];
//        NSLog(@"Mutated non __block vesion %@", testMutableArray);

        //this __block trick works fine. Compiler doesn't allow assingment
//        int y = 5;
//        x = x + y;
        
        
        
    };
    
    myTestBlock(2,3);

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply((size_t)3, queue, ^(size_t i) {
        NSLog(@"Repeat this 3 times, %zu", i);
    });
    NSLog(@"\n");
    
}

- (void)testFunction {
    NSLog(@"test function called from a block");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
