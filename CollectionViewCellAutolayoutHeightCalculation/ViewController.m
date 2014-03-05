//
//  ViewController.m
//  CollectionViewCellAutolayoutHeightCalculation
//
//  Created by Daniel Tull on 05.03.2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"

static NSString *const ViewControllerCellReuseIdentifier = @"cell";

@interface ViewController () <UICollectionViewDelegateFlowLayout>
@property (nonatomic) NSArray *texts;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.texts = @[
		@"Using autolayout to calculate collection view cell heights",
		@"Currently I have a UIView that contains subviews (labels, image views, buttons etc.) and the uiview uses autolayout in a XIB. All the constraints are working pretty must how I expect. This UIView also has a class called VPUserView. (in the Custom class in IB)",
		@"Small string"
	];

	[self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:ViewControllerCellReuseIdentifier];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.texts.count;
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ViewControllerCellReuseIdentifier forIndexPath:indexPath];
	cell.text = self.texts[indexPath.row];
	NSLog(@"%@:%@ %@", self, NSStringFromSelector(_cmd), cell);
	return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	Cell *cell = [Cell sizingCell];
	CGSize targetSize = CGSizeMake(collectionView.bounds.size.width, 0.0f);
	CGSize size = [cell systemLayoutSizeFittingSize:targetSize];
	return size;
}

@end
