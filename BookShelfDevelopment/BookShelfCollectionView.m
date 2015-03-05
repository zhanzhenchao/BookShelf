//
//  BookShelfCollectionView.m
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import "BookShelfCollectionView.h"
#import "Layout.h"
#import "CellView.h"

@interface BookShelfCollectionView()

@property(nonatomic, strong)Layout *viewLayout;

@end

//cell stroyboard ID
static NSString * const reuseIdentifier = @"BookCell";

@implementation BookShelfCollectionView

#pragma mark - Properties
@synthesize viewLayout = _viewLayout;

- (Layout *)viewLayout{
    if (!_viewLayout) _viewLayout = [[Layout alloc] init];
    return _viewLayout;
}

- (void)setViewLayout:(Layout *)viewLayout{
    _viewLayout = viewLayout;
    [_viewLayout invalidateLayout];
}

- (void)setPdfDocument:(CGPDFDocumentRef)pdfDocument{
    _pdfDocument = pdfDocument;
    [self.collectionView reloadData];
}

#pragma mark - ViewContoller Life
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.collectionView reloadData];
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BookShelfBackground"]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.collectionViewLayout = self.viewLayout;
//    [self.collectionView registerClass:[CellView class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - UICollectionViewController DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CellView *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.image.image = [UIImage imageNamed:@"sample"];
    
    return cell;
}

@end
