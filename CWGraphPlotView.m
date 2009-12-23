//
//  CWGraphicPlotView.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWGraphPlotView.h"

const int AXIS_SPACING = 20;

@interface CWGraphPlotView ( )
- (void)drawAxisToContext:(NSGraphicsContext*)context;

- (void) drawFromDataSource:(id<CWGraphPlotViewDataSource>)dataSource;

@property (nonatomic, retain) CWGraphPlotViewAxis* horAxis;
@property (nonatomic, retain) CWGraphPlotViewAxis* vertAxis;

@end

@implementation CWGraphPlotView

@synthesize dataSources = _dataSources;
@synthesize delegate	= _delegate;
@synthesize precision	= _precision;
@synthesize horAxis = _horAxis, vertAxis = _vertAxis;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		_dataSources = [[NSMutableArray array] retain];
    }
    return self;
}

- (void) reloadData {
	// reset axises
	self.horAxis = nil;
	self.vertAxis = nil;
	
	[self setNeedsDisplay:YES];
}

- (void)drawAxisToContext:(NSGraphicsContext*)context {
	self.horAxis = [_delegate graphicPlotView:self axisWithType:CWGraphPlotAxisHorizontal];
	self.vertAxis = [_delegate graphicPlotView:self axisWithType:CWGraphPlotAxisVertical];
	
	[self.horAxis drawWithType:CWGraphPlotAxisHorizontal context:context];
	[self.vertAxis drawWithType:CWGraphPlotAxisVertical context:context];
}

- (void)drawRect:(NSRect)dirtyRect {
    NSGraphicsContext* context = [NSGraphicsContext currentContext];

	// make background color
	NSBezierPath *bp = [NSBezierPath bezierPathWithRect:NSMakeRect(0, 0, self.frame.size.width, self.frame.size.height)];
	[[NSColor whiteColor] set];
	[bp fill];
	
	[self drawAxisToContext:context];
	
	if ( !_horAxis ) 
	{
		NSAssert(0, @"no horizontal axis!");
		return;
	}
	
	double minYValue = INFINITY;
	double maxYValue = -INFINITY;
	
	for (id<CWGraphPlotViewDataSource> dataSource in _dataSources) {
		if ( ![dataSource enabled] ) {
			continue;
		}
		
		NSBezierPath* aPath = [NSBezierPath bezierPath];
		[aPath moveToPoint:NSMakePoint(0, 0)];
		NSColor* lineColor = [dataSource plotColor];
		[lineColor setStroke];
		
		for (double curArg = _horAxis.axisMinValue; curArg <= _horAxis.axisMaxValue; curArg += _horAxis.step) {
			if ( ! [dataSource canProvideDataForArgument:curArg] ) {
				break;
			}
			
			double value = [dataSource graphicPlotView:self valueForArgument:curArg];
			[aPath lineToPoint:NSMakePoint(curArg, value)];
			
			minYValue = min( minYValue, value );
			maxYValue = max( maxYValue, value );
		}
		
		double ratio = self.frame.size.height / (maxYValue - minYValue);
		if ( ratio < 0 ) ratio *= (-1.0);
		
		// make affine transform
		
		[aPath stroke];
	}
	
	[super drawRect:dirtyRect];
}

- (void) dealloc {
	[_dataSources release];
	
	[super dealloc];
}
@end
