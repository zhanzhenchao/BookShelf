//
//  Scanner.m
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import "Scanner.h"

@interface Scanner()

#pragma mark - Text showing

// Text-showing operators
void quot(CGPDFScannerRef scanner, void *info);
void doubleQuot(CGPDFScannerRef scanner, void *info);
void TJ(CGPDFScannerRef scanner, void *info);

#pragma mark Text positioning

// Text-positioning operators
void Td(CGPDFScannerRef scanner, void *info);
void TD(CGPDFScannerRef scanner, void *info);
void Tm(CGPDFScannerRef scanner, void *info);
void TStar(CGPDFScannerRef scanner, void *info);

#pragma mark Text state

// Text state operators
void BT(CGPDFScannerRef scanner, void *info);
void Tc(CGPDFScannerRef scanner, void *info);
void Tw(CGPDFScannerRef scanner, void *info);
void Tz(CGPDFScannerRef scanner, void *info);
void TL(CGPDFScannerRef scanner, void *info);
void Tf(CGPDFScannerRef scanner, void *info);
void Ts(CGPDFScannerRef scanner, void *info);

#pragma mark Graphics state

// Special graphics state operators
void q(CGPDFScannerRef scanner, void *info);
void Q(CGPDFScannerRef scanner, void *info);
void cm(CGPDFScannerRef scanner, void *info);

/* Returts the operator callbacks table for scanning page stream */
@property (nonatomic)CGPDFOperatorTableRef operatorTable;

@end

@implementation Scanner

- (NSMutableString *)content{
    if(!_content) _content = [[NSMutableString alloc] init];
    return _content;
}

#pragma mark - Text showing operator
/* Show a string */
void Tj(CGPDFScannerRef scanner, void *info)
{
    CGPDFStringRef pdfString = nil;
    if (!CGPDFScannerPopString(scanner, &pdfString)) return;
    didScanString(pdfString, (__bridge Scanner *)(info));
}

void didScanString(CGPDFStringRef pdfString, Scanner *scanner){
    if (!pdfString) {
        //error
    }
    NSString *string = (__bridge NSString *)(CGPDFStringCopyTextString(pdfString));
    [scanner.content appendString:string];
}

#pragma mark - OperatorTable
/* The operator table used for scanning PDF pages */
- (CGPDFOperatorTableRef)operatorTable{
    if (_operatorTable)
    {
        return _operatorTable;
    }
    
    _operatorTable = CGPDFOperatorTableCreate();
    
    // Text-showing operators
    CGPDFOperatorTableSetCallback(_operatorTable, "Tj", &Tj);
    
    return _operatorTable;
}

//Checking whether the PDF is legal
+ (BOOL)checkForPDF:(CGPDFDocumentRef)document{
    if (document == NULL){
        //error
        return NO;
    }
    if (CGPDFDocumentIsEncrypted(document)){
        //deal with the passwords
        CGPDFDocumentRelease(document);
        return NO;
    }
    if (CGPDFDocumentIsUnlocked(document)){
        //document can't unlock
        CGPDFDocumentRelease(document);
        return NO;
    }
    if (CGPDFDocumentGetNumberOfPages(document) == 0) {
        CGPDFDocumentRelease(document);
        return NO;
    }
    return YES;
}

#pragma mark - Scanner

- (void)scanDocumentPage:(NSUInteger)pageNumber PDF:(CGPDFDocumentRef) document{
    CGPDFPageRef page = CGPDFDocumentGetPage(document, pageNumber);
    [self scanPage:page];
    
}

//Scanning each page of a document
- (void)scanPage:(CGPDFPageRef) page{
    CGPDFContentStreamRef contentStream = CGPDFContentStreamCreateWithPage(page);
    CGPDFScannerRef scanner = CGPDFScannerCreate(contentStream, self.operatorTable, (__bridge void *)(self));
    CGPDFScannerScan(scanner);
    NSLog([NSString stringWithFormat:@"%@",self.content], nil);
    CGPDFScannerRelease(scanner);
    CGPDFContentStreamRelease(contentStream);
    CGPDFOperatorTableRelease(self.operatorTable);
}

@end

