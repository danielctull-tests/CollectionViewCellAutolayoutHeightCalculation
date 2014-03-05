//
//  Label.m
//  CollectionViewCellAutolayoutHeightCalculation
//
//  Created by Daniel Tull on 05.03.2014.
//  Copyright (c) 2014 Daniel Tull. All rights reserved.
//

#import "Label.h"

@interface Label ()
@property (nonatomic) CGSize internalIntrinsicContentSize;
@end

@implementation Label

- (CGSize)intrinsicContentSize {
	CGFloat width = [self maximumWidthForView:self inView:self.superview];

	// Used for laying out the actual views when a width constraint may not be present
	if (width == 0.0f) {
		return [super intrinsicContentSize];
	}

	return [self sizeThatFits:CGSizeMake(width, 0.0f)];
}

- (CGFloat)maximumWidthForView:(UIView *)view inView:(UIView *)superview {

	// Look for a width constraint for the given view
	// If it exists, this is is our maximum
	for (NSLayoutConstraint *constraint in view.constraints) {
		if ([constraint.firstItem isEqual:view] && constraint.firstAttribute == NSLayoutAttributeWidth) {
			return constraint.constant;
		}
	}

	// If there's no super view, we fail
	if (!superview) return 0.0f;

	// If the super view has no constraints, try again with its super view
	// In the demo, the label is contrained to it's superview's superview (the cell)
	if (superview.constraints.count == 0) {
		return [self maximumWidthForView:view inView:superview.superview];
	}

	// Get the maximum width of the superview in its superview
	CGFloat maximumWidth =  [self maximumWidthForView:superview inView:superview.superview];

	// No point in calculating the leading and trailing if we can't get a valid maximum width in a superview
	if (maximumWidth == 0.0f) return 0.0f;

	// Get the margins (trailing and leading) values
	CGFloat leading = 0.0f;
	CGFloat trailing = 0.0f;

	for (NSLayoutConstraint *constraint in superview.constraints) {

		if ([constraint.firstItem isEqual:view] && constraint.firstAttribute == NSLayoutAttributeLeading && [constraint.secondItem isEqual:superview] && constraint.secondAttribute == NSLayoutAttributeLeading) {
			leading = constraint.constant;

		} else if ([constraint.firstItem isEqual:superview] && constraint.firstAttribute == NSLayoutAttributeLeading && [constraint.secondItem isEqual:view] && constraint.secondAttribute == NSLayoutAttributeLeading) {
			leading = constraint.constant;

		} else if ([constraint.firstItem isEqual:view] && constraint.firstAttribute == NSLayoutAttributeLeft && [constraint.secondItem isEqual:superview] && constraint.secondAttribute == NSLayoutAttributeLeft) {
			leading = constraint.constant;

		} else if ([constraint.firstItem isEqual:superview] && constraint.firstAttribute == NSLayoutAttributeLeft && [constraint.secondItem isEqual:view] && constraint.secondAttribute == NSLayoutAttributeLeft) {
			leading = constraint.constant;




		} else if ([constraint.firstItem isEqual:view] && constraint.firstAttribute == NSLayoutAttributeTrailing && [constraint.secondItem isEqual:superview] && constraint.secondAttribute == NSLayoutAttributeTrailing) {
			trailing = constraint.constant;

		} else if ([constraint.firstItem isEqual:superview] && constraint.firstAttribute == NSLayoutAttributeTrailing && [constraint.secondItem isEqual:view] && constraint.secondAttribute == NSLayoutAttributeTrailing) {
			trailing = constraint.constant;

		} else if ([constraint.firstItem isEqual:view] && constraint.firstAttribute == NSLayoutAttributeRight && [constraint.secondItem isEqual:superview] && constraint.secondAttribute == NSLayoutAttributeRight) {
			trailing = constraint.constant;

		} else if ([constraint.firstItem isEqual:superview] && constraint.firstAttribute == NSLayoutAttributeRight && [constraint.secondItem isEqual:view] && constraint.secondAttribute == NSLayoutAttributeRight) {
			trailing = constraint.constant;

		}
	}

	// Return the maximimum width of the superview, minus our margins to it
	return maximumWidth - leading - trailing;
}


@end
