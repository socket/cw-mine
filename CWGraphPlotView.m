//
//  CWGraphicPlotView.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWGraphPlotView.h"
#import "CWGraphPlotDataSource.h"

const int AXIS_SPACING = 20;
const int GUIDE_SPACING = 40;
const int GUIDE_LENGTH = 5;

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
	
	NSMutableArray* paths = [NSMutableArray array];
	
	for (id<CWGraphPlotViewDataSource> dataSource in _dataSources) {
		if ( ![dataSource enabled] ) {
			continue;
		}
		
		int capacity = (_horAxis.axisMaxValue - _horAxis.axisMinValue) / _horAxis.step;
		
		NSMutableArray* points = [NSMutableArray arrayWithCapacity:capacity];
		// get values from datasource and find global extremum for all datasources
		for (double curArg = _horAxis.axisMinValue; curArg <= _horAxis.axisMaxValue; curArg += _horAxis.step) {
			if ( ! [dataSource canProvideDataForArgument:curArg] ) {
				break;
			}
			
			double value = [dataSource graphicPlotView:self valueForArgument:curArg];
			
			minYValue = MIN( minYValue, value );
			maxYValue = MAX( maxYValue, value );
			
			[points addObject: [NSValue valueWithPoint:CGPointMake(curArg, value)]];
		}
		
				
		[paths addObject:points];
	}
	
	if ( minYValue != INFINITY && maxYValue != INFINITY ) {
		double size = (maxYValue - minYValue);
		double hsize = (_horAxis.axisMaxValue - _horAxis.axisMinValue);
		
		if ( size == 0 ) size = 1.0;
		if ( hsize == 0 ) hsize = 1.0;
		
		double yratio = self.frame.size.height / size;
		if ( yratio < 0 ) yratio *= (-1.0);
		double xratio = self.frame.size.width / hsize;
		
		// draw guides
		[[NSColor grayColor] setStroke];
		
		// horizontal guide
		NSDictionary* fontAttributes = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSFont fontWithName:@"Helvetica" size:9.0], [NSColor grayColor], nil] forKeys:[NSArray arrayWithObjects:NSFontAttributeName, NSForegroundColorAttributeName, nil]];
		
		NSBezierPath* hguide = [NSBezierPath bezierPath];
		for( int i = 1; i < self.frame.size.width / GUIDE_SPACING+1; ++i) {
			[hguide moveToPoint:CGPointMake(i * GUIDE_SPACING, 0)];
			[hguide lineToPoint:CGPointMake(i * GUIDE_SPACING, GUIDE_LENGTH)];
			
			NSString* title = [NSString stringWithFormat:@"%.2f", i * GUIDE_SPACING * 1.0 / xratio];
			CGSize sizeTitle = [title sizeWithAttributes:fontAttributes];
			[title drawAtPoint:CGPointMake(i*GUIDE_SPACING-sizeTitle.width/2, GUIDE_LENGTH) withAttributes:fontAttributes];
		}
		[hguide stroke];

		// vertical guide
		NSBezierPath* vguide = [NSBezierPath bezierPath];
		for( int i = 1; i < self.frame.size.height / GUIDE_SPACING + 1; ++i) {
			[vguide moveToPoint:CGPointMake(0, i * GUIDE_SPACING)];
			[vguide lineToPoint:CGPointMake(GUIDE_LENGTH, i * GUIDE_SPACING)];
			
			NSString* title = [NSString stringWithFormat:@"%.2f", i * GUIDE_SPACING * 1.0 / yratio];
			CGSize sizeTitle = [title sizeWithAttributes:fontAttributes];
			[title drawAtPoint:CGPointMake(GUIDE_LENGTH, i*GUIDE_SPACING-sizeTitle.height/2) withAttributes:fontAttributes];
			
		}
		[vguide stroke];
		
		NSAffineTransform* xform = [NSAffineTransform transform];
		[xform scaleXBy:xratio yBy:yratio];
		//[xform concat];	
				
		int i = 0;
		for (NSMutableArray* points in paths) {
			NSBezierPath* aPath = [NSBezierPath bezierPath];
			[aPath moveToPoint:NSMakePoint(0, 0)];
			
			NSColor* lineColor = [[_dataSources objectAtIndex:i++] plotColor];
			[lineColor setStroke];
			
			for (NSValue* point in points) {
				CGPoint aPoint = NSPointToCGPoint( [point pointValue] );
				
				aPoint = [xform transformPoint:aPoint];
				[aPath lineToPoint:aPoint ];
			}
			[aPath stroke];
		}
	}
	
	
	[super drawRect:dirtyRect];
}

- (void) dealloc {
	[_dataSources release];
	
	[super dealloc];
}
@end
