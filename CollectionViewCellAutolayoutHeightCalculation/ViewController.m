//
//  ViewController.m
//  CollectionViewCellAutolayoutHeightCalculation
//
//  Created by Daniel Tull on 05.03.2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"

static NSString *const ViewControllerCellReuseIdentifier = @"Cell";

@interface ViewController () <UICollectionViewDelegateFlowLayout>
@property (nonatomic) NSArray *texts;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.texts = @[
		@"Using autolayout to calculate collection view cell heights",
		@"Currently I have a UIView that contains subviews (labels, image views, buttons etc.) and the uiview uses autolayout in a XIB. All the constraints are working pretty must how I expect. This UIView also has a class called VPUserView. (in the Custom class in IB)",
		@"Small string",
		@"I used a technique described in Cocoa Programming for Mac OSX 4th Ed by Hillegass & Preble. The book advises using an NSBox as a view container and switching the views into it using code. The book also includes some handy code for manually resizing the external containing window to hold the view you just switched to."
	];

	[self.collectionView registerNib:[Cell nib] forCellWithReuseIdentifier:ViewControllerCellReuseIdentifier];
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
	return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

	Cell *cell = [Cell sizingCell];
	cell.text = self.texts[indexPath.row];

	NSLayoutConstraint *maxWidth = [NSLayoutConstraint constraintWithItem:cell
																attribute:NSLayoutAttributeWidth
																relatedBy:NSLayoutRelationEqual
																   toItem:nil
																attribute:NSLayoutAttributeNotAnAttribute
															   multiplier:1.0f
																 constant:collectionView.bounds.size.width];
	[cell addConstraint:maxWidth];
	CGSize size = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
	[cell removeConstraint:maxWidth];
	
	return size;
}

@end
