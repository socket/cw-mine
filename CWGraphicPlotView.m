//
//  CWGraphicPlotView.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWGraphicPlotView.h"

@interface CWGraphicPlotView ( )
- (void) drawAxis;
- (void) drawFromDataSource:(id<CWGraphicPlotViewDataSource>)dataSource;
@end

@implementation CWGraphicPlotView

@synthesize dataSources = _dataSources;
@synthesize delegate	= _delegate;
@synthesize precision	= _precision;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void) reloadData {
	[self setNeedsDisplay:YES];
}

- (void)drawAxis {
	
}

- (void)drawRect:(NSRect)dirtyRect {
    NSGraphicsContext* aContext = [NSGraphicsContext currentContext];
	
	[super drawRect:dirtyRect];
}

- (void) dealloc {
	[_dataSources release];
	
	[super dealloc];
}
@end
