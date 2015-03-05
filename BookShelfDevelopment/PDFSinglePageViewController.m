//
//  PDFSinglePageViewController.m
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import "PDFSinglePageViewController.h"

@interface PDFSinglePageViewController()

@property (weak, nonatomic) IBOutlet pageView *pdfPageView;

@end

@implementation PDFSinglePageViewController

- (void)setCurrentPage:(CGPDFPageRef)currentPage{
    _currentPage = currentPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pdfPageView.page = self.currentPage;
}

@end
