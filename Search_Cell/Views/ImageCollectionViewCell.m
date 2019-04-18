//
//  ImageCollectionViewCell.m
//  Search_Cell
//
//  Created by Вова on 07.04.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.cornerRadius = 10.0;
        self.layer.borderWidth = 4.0;
        self.contentView.layer.cornerRadius = 10.0;
        self.contentView.layer.masksToBounds = YES;
        self.imageView = [UIImageView new];
        [self.contentView addSubview:self.imageView];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end
