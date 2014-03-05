//
//  Cell.m
//  CollectionViewCellAutolayoutHeightCalculation
//
//  Created by Daniel Tull on 05.03.2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

#import "Cell.h"

@interface Cell ()
@property (nonatomic, weak) IBOutlet UILabel *textLabel;
@end

@implementation Cell

+ (UINib *)nib {
	static UINib *nib;
	static dispatch_once_t nibToken;
	dispatch_once(&nibToken, ^{
		nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
	});
	return nib;
}

+ (Cell *)sizingCell {
	static Cell *sizingCell;
	static dispatch_once_t sizingCellToken;
	dispatch_once(&sizingCellToken, ^{
		UINib *nib = [self nib];
		NSArray *objects = [nib instantiateWithOwner:nil options:nil];
		sizingCell = [objects firstObject];
	});
	return sizingCell;
}

- (void)setText:(NSString *)text {
	_text = [text copy];
	self.textLabel.text = _text;
}

@end
