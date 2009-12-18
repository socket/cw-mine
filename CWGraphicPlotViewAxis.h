//
//  CWGraphicPlotAxis.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
	CWGraphicPlotAxisHorizontal,
	CWGraphicPlotAxisVertical
} CWGraphicPlotAxisType;


@interface CWGraphicPlotViewAxis : NSObject {
@private
	NSString*	_axisTitle;
	double		_axisMinValue;
	double		_axisMaxValue;
}

+ (id) axisWithTitle:(NSString*)title minValue:(double)minValue maxValue:(double)maxValue;
- (id) initWithTitle:(NSString*)title minValue:(double)minValue maxValue:(double)maxValue;

@property (nonatomic, copy)   NSString* axisTitle;
@property (nonatomic, assign) double axisMinValue;
@property (nonatomic, assign) double axisMaxValue;

@end
