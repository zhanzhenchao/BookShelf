//
//  pageView.m
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import "pageView.h"

@implementation pageView

- (void)setPage:(CGPDFPageRef)page{
    _page = page;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    CGContextDrawPDFPage(context, self.page);
    
}

@end
