//
//  CellView.m
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import "CellView.h"

//Item Size
#define CELL_ITEM_SIZE_WIDTH 72.5
#define CELL_ITEM_SIZE_HEIGHT 107.5

@implementation CellView

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CELL_ITEM_SIZE_WIDTH,CELL_ITEM_SIZE_HEIGHT)];
        self.image.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.image];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
//        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame),CGRectGetHeight(frame))];
//        self.image.contentMode = UIViewContentModeScaleAspectFit;
//        [self.contentView addSubview:self.image];
//    }
//    return self;
//}

@end
