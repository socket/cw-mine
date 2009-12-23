//
//  CWGraphicPlotAxis.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWGraphPlotViewAxis.h"


@implementation CWGraphPlotViewAxis
@synthesize axisTitle = _axisTitle;
@synthesize axisMinValue = _axisMinValue;
@synthesize axisMaxValue = _axisMaxValue;
@synthesize step = _step;

+ (id) axisWithTitle:(NSString*)title minValue:(double)minValue maxValue:(double)maxValue {
	return [[[[self class] alloc] initWithTitle:title minValue:minValue maxValue:maxValue] autorelease];
}

- (id) initWithTitle:(NSString*)title minValue:(double)minValue maxValue:(double)maxValue {
	if ( self = [super init] ) {
		self.axisTitle = title;
		_axisMinValue = minValue;
		_axisMaxValue = maxValue;
		_step = 1;
	}
	return self;
}

- (void) drawWithType:(CWGraphPlotAxisType)type context:(NSGraphicsContext*)aContext{
	
}

- (void) dealloc {
	self.axisTitle = nil;
	
	[super dealloc];
}
@end
