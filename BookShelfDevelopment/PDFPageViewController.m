//
//  PDFPageViewController.m
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import "PDFPageViewController.h"
#import "PDFSinglePageVIewController.h"

@interface PDFPageVIewControlle

@property (assign) BOOL pageIsAnimating;

@end

@implementation PDFPageViewController

#pragma mark - PageViewController Life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    PDFSinglePageViewController *startingViewController = (PDFSinglePageViewController *)[self viewControllerAtIndex:1];
    if (startingViewController != nil){
        self.dataSource = self;
        
        [self setViewControllers:@[startingViewController]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                      completion:nil];
    }
    
}

#pragma mark - PDFPageController
- (UIViewController *)viewControllerAtIndex: (NSInteger)index{
    if (CGPDFDocumentGetNumberOfPages(self.pdfBook) == 0
        || (index >= CGPDFDocumentGetNumberOfPages(self.pdfBook))) {
        return nil;
    }

    PDFSinglePageViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pageContentViewController"];

    CGPDFPageRef page = CGPDFDocumentGetPage(self.pdfBook, index);
    pageContentViewController.currentPage = page;

    pageContentViewController.pageIndex = index;
//    pageContentViewController.pdfTitle.text = [NSString stringWithFormat:@"%ld",(long)index];

    return pageContentViewController;
}

#pragma mark - UIViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((PDFSinglePageViewController *) viewController).pageIndex;
    return [self viewControllerAtIndex: (index + 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = ((PDFSinglePageViewController *) viewController).pageIndex;
    return [self viewControllerAtIndex: (index - 1)];
}

#pragma mark - UIViewControllerDataSource

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return CGPDFDocumentGetNumberOfPages(self.pdfBook);
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

@end
