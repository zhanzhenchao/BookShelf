//
//  FetchPDF.m
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import "FetchPDF.h"
#import "Scanner.h"
#import "PDFPageViewController.h"

@implementation FetchPDF

- (void)viewDidLoad{
    [super viewDidLoad];
    [self fetchPDF];
    //[self parsePDF];
}

- (void)fetchPDF{
    CFURLRef PDFurl = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("CrackCode.pdf"), NULL, NULL);
    CGPDFDocumentRef PDFbook = CGPDFDocumentCreateWithURL(PDFurl);
    
    self.pdfDocument = PDFbook;
}

- (void)parsePDF{
    Scanner *scanner = [[Scanner alloc] init];
    [scanner scanDocumentPage:4 PDF:self.pdfDocument];
}

#pragma mark - Segue Support
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:[PDFPageViewController class]]){
        NSIndexPath *SelectedIndexpath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        if (SelectedIndexpath){
            if ([segue.identifier isEqualToString:@"pdf pageViewContoller"]) {
                PDFPageViewController *PDFpageView = (PDFPageViewController *)segue.destinationViewController;
                PDFpageView.pdfBook = self.pdfDocument;
            }
        }
    }
}

@end
