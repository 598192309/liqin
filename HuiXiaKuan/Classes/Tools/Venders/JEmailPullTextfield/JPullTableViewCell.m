//
//
//  Created by mythkiven on 15/11/12.
//  Copyright © 2015年 3code. All rights reserved.
//
#import "JPullTableViewCell.h"

@implementation JPullTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.leftEdge, 0, self.frame.size.width-self.leftEdge, self.frame.size.height)];
    self.emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(Adaptor_Value(10), 0, self.frame.size.width-Adaptor_Value(20), self.frame.size.height)];

    self.emailLabel.textColor = [UIColor lightGrayColor];
    self.emailLabel.numberOfLines = 0;
    self.emailLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.emailLabel];
    
    self.lineLeftConstraint.constant = Adaptor_Value(20);
    self.lineRightConstraint.constant = Adaptor_Value(20);
    self.lineView.backgroundColor = HexRGB(0xF1F0F3);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
