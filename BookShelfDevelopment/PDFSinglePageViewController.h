//
//  PDFSinglePageViewController.h
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pageView.h"

@interface PDFSinglePageViewController : UIViewController

@property (nonatomic)NSUInteger pageIndex;
@property (nonatomic)CGPDFPageRef currentPage;

@end
