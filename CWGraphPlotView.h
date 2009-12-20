//
//  CWGraphicPlotView.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWGraphPlotViewAxis.h"

@class CWGraphPlotView;

@protocol CWGraphPlotViewDataSource<NSObject>
- (double) graphicPlotView:(CWGraphPlotView*)plotView valueForArgument:(double)arg;
- (BOOL) canProvideDataForArgument:(double)arg;
- (BOOL) enabled;
@end

@protocol CWGraphPlotViewDelegate<NSObject>
@required
- (CWGraphPlotViewAxis*) graphicPlotView:(CWGraphPlotView*)view axisWithType:(CWGraphPlotAxisType)aType;

@optional
- (void)	graphicPlotView:(CWGraphPlotView*) didSelectGraphicWithDataSource:(id<CWGraphPlotViewDataSource>)dataSource;
- (NSColor*) graphicPlotView:(CWGraphPlotView*) colorForDataSource:(id<CWGraphPlotViewDataSource>)dataSource;

@end


@interface CWGraphPlotView : NSView {
	@protected
	
	id<CWGraphPlotViewDelegate>					_delegate;		// weak ptr
	NSMutableArray<CWGraphPlotViewDataSource>*	_dataSources;
	
	CWGraphPlotViewAxis*							_vertAxis;
	CWGraphPlotViewAxis*							_horAxis;
	
	double	_precision;
}

- (id) initWithFrame:(NSRect)frame;

- (void) reloadData;

@property (nonatomic, readonly) NSMutableArray<CWGraphPlotViewDataSource>* dataSources;
@property (nonatomic, assign)	id<CWGraphPlotViewDelegate>	delegate;		// a weak reference
@property (nonatomic, assign)	double							precision;

@end
