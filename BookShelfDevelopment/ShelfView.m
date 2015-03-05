//
//  ShelfView.m
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import "ShelfView.h"

#define bookShelfKind @"ShelfView"

@implementation ShelfView

//Set image for shelf view
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wood"]]];
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(0, 5);
    }
    return self;
}

+ (NSString *)kind{
    return (NSString *)bookShelfKind;
}

@end