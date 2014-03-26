//
//  LibraryTestViewController.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 26/03/14.
//
//

#import "LibraryTestViewController.h"

@interface LibraryTestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LibraryTestViewController

//- (id)initWithCoder:(NSCoder *)aDecoder {
//    NSLog(@"init with coder");
//    return self;
//}

- (void)updateUI {
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"Init with nib name");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"View did load");
    self.titleLabel.text = self.bookToShow.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
