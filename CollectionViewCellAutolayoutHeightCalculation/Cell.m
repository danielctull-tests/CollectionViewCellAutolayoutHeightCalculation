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

+ (Cell *)sizingCell {
	static Cell *sizingCell;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		UINib *nib = [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
		NSArray *objects = [nib instantiateWithOwner:nil options:nil];
		sizingCell = [objects firstObject];
	});
	return sizingCell;
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
	self.textLabel.preferredMaxLayoutWidth = targetSize.width - 40.0f;
	CGSize size = [self.contentView systemLayoutSizeFittingSize:targetSize];
	NSLog(@"%@:%@ %@", self, NSStringFromSelector(_cmd), NSStringFromCGSize(size));
	return size;
}

- (void)setText:(NSString *)text {
	_text = [text copy];
	self.textLabel.text = _text;
}

@end
