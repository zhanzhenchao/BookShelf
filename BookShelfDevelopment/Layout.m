//
//  Layout.m
//  BookShelfDevelopment
//
//  Created by Rico on 15/3/3.
//  Copyright (c) 2015年 zhanzhenchao. All rights reserved.
//

#import "Layout.h"
#import "LayoutViewProperties.h"
#import "ShelfView.h"

#define ADD_ADDICTIONAL_DECORATION_VIEW 3

@interface Layout()

@property(nonatomic, strong)NSDictionary *shelfLayout;

@end

@implementation Layout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(CELL_ITEM_SIZE_WIDTH, CELL_ITEM_SIZE_HEIGHT);
        self.sectionInset = UIEdgeInsetsMake(SECTION_INSET_TOP, SECTION_INSET_LEFT, SECTION_INSET_BOTTOM, SECTION_INSET_RIGHT);
        self.minimumInteritemSpacing = MINIMUM_INTER_ITEM_SPACING;
        self.minimumLineSpacing = MINIMUM_LINE_SPACING;
        
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        [self registerClass:[ShelfView class] forDecorationViewOfKind:[ShelfView kind]];
    }
    return self;
}

//Calculate the properties of Decoration View First
- (void)prepareLayout{
    [super prepareLayout];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        long sectionCount = [self.collectionView numberOfSections];
        
        CGFloat y = 0;
        CGFloat availableWidth = self.collectionViewContentSize.width - (self.sectionInset.left + self.sectionInset.right);
        int itemAcross = floorf(availableWidth + self.minimumInteritemSpacing) / (self.itemSize.width + self.minimumInteritemSpacing);
        
        for (int section = 0; section < sectionCount; section++) {
            y += self.sectionInset.top;
            
            long itemCount = [self.collectionView numberOfItemsInSection:section];
            int rowCount = ceilf(itemCount / (floor(itemAcross)));
            
            for (int row = 0; row < rowCount + ADD_ADDICTIONAL_DECORATION_VIEW; row++) {
                y += self.itemSize.height;
                
                dictionary[[NSIndexPath indexPathForItem:row inSection:section]] = [NSValue valueWithCGRect:CGRectMake(0, y, self.collectionViewContentSize.width, DECORATION_VIEW_SIZE_HEIGHT)];
                
                if (row < rowCount) {
                    y += self.minimumLineSpacing;
                }
            }
            y += self.sectionInset.bottom;
        }
    }
    self.shelfLayout = [NSDictionary dictionaryWithDictionary:dictionary];
}

//Return All the LayoutAttributes in Array
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *newArray = [array mutableCopy];
    
    for (UICollectionViewLayoutAttributes *attribute in array){
        attribute.zIndex = 1;
    }
    
    [self.shelfLayout enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (CGRectIntersectsRect([obj CGRectValue], rect)) {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:[ShelfView kind] withIndexPath:key];
            
            attributes.frame = [obj CGRectValue];
            attributes.zIndex = 0;
            [newArray addObject: attributes];
        }
    }];
    array = [NSArray arrayWithArray:newArray];
    return array;
}

//Setting for the properties of cell
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attribute = [super layoutAttributesForItemAtIndexPath:indexPath];
    attribute.zIndex = 1;
    return attribute;
}


@end



