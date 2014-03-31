//
//  LibraryTableViewCell.h
//  TochkaK
//
//  Created by Alexandra Vtyurina on 31/03/14.
//
//

#import <UIKit/UIKit.h>

@interface LibraryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@end
