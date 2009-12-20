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
	if ( !_horAxis ) {
		self.horAxis = [_delegate graphicPlotView:self axisWithType:CWGraphPlotAxisHorizontal];
	}
	if ( !_vertAxis ) {
		self.vertAxis = [_delegate graphicPlotView:self axisWithType:CWGraphPlotAxisVertical];
	}
	
	[self.horAxis drawWithType:CWGraphPlotAxisHorizontal context:context];
	[self.vertAxis drawWithType:CWGraphPlotAxisVertical context:context];
}

- (void)drawRect:(NSRect)dirtyRect {
    NSGraphicsContext* context = [NSGraphicsContext currentContext];
	
	[self drawAxisToContext:context];
	
	for (id<CWGraphPlotViewDataSource> dataSource in _dataSources) {
		if ( ![dataSource enabled] || ![dataSource canProvideDataForArgument:_horAxis.axisMinValue endArgument:_horAxis.axisMaxValue step:_horAxis.step]) {
			continue;
		}
		
		NSColor* lineColor = [NSColor redColor];
		if ( [_delegate respondsToSelector:@selector(graphicPlotView:colorForDataSource:) ] ) {
			lineColor = [_delegate graphicPlotView:self colorForDataSource:dataSource];
		}
		
		for (double curArg = _horAxis.axisMinValue; curArg <= _horAxis.axisMaxValue; curArg += _horAxis.step) {
			double value = [dataSource graphicPlotView:self valueForArgument:curArg];
			
			//FIXME: add to path
		}
						
	}
	
	[super drawRect:dirtyRect];
}

- (void) dealloc {
	[_dataSources release];
	
	[super dealloc];
}
@end
