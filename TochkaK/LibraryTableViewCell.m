//
//  LibraryTableViewCell.m
//  TochkaK
//
//  Created by Alexandra Vtyurina on 31/03/14.
//
//

#import "LibraryTableViewCell.h"
@interface LibraryTableViewCell ()


@end
@implementation LibraryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
