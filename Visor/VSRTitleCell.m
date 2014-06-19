//
//  VSRTitleCell.m
//  Visor
//
//  Created by Bradley Ringel on 6/16/14.
//  Copyright (c) 2014 Bradley Ringel. All rights reserved.
//

#import "VSRTitleCell.h"

@implementation VSRTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setPosterImageData:(NSData *)posterImageData{
    _posterImageData = posterImageData;
    self.posterImageView.image = [UIImage imageWithData:posterImageData];
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
