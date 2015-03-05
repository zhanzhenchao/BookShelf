//
//  Scanner.h
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Scanner : NSObject

@property (nonatomic)CGPDFDocumentRef pdfDocument;
@property (nonatomic, strong)NSMutableString *content;

/* Initialize with a PDF document */
//- (id)initWithDocument:(CGPDFDocumentRef)document;

//Check whether the PDF is legal or not
+ (BOOL)checkForPDF: (CGPDFDocumentRef) document;

- (void)scanDocumentPage: (NSUInteger) pageNumber PDF:(CGPDFDocumentRef) document;

//Scan page of a document
- (void)scanPage: (CGPDFPageRef) page;

@end
