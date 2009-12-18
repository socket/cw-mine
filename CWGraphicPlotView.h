//
//  CWGraphicPlotView.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWGraphicPlotViewAxis.h"

@class CWGraphicPlotView;

@protocol CWGraphicPlotViewDataSource
@required
- (NSNumber*) graphicPlotView:(CWGraphicPlotView*) valueForArgument:(NSNumber*)anArgument;
@end

@protocol CWGraphicPlotViewDelegate
@required
- (CWGraphicPlotViewAxis*) graphicPlotView:(CWGraphicPlotView*)view axisWithType:(CWGraphicPlotAxisType)aType;

@optional
- (NSColor*) graphicPlotView:(CWGraphicPlotView*) colorForDataSource:(id<CWGraphicPlotViewDataSource>)dataSource;
- (void)	graphicPlotView:(CWGraphicPlotView*) didSelectGraphicWithDataSource:(id<CWGraphicPlotViewDataSource>)dataSource;
@end


@interface CWGraphicPlotView : NSView {
	@protected
	
	id<CWGraphicPlotViewDelegate>					_delegate;		// weak ptr
	NSMutableArray<CWGraphicPlotViewDataSource>*	_dataSources;
	NSMutableDictionary*							_axisDictionary;
	
	double	_precision;
}

- (id) initWithFrame:(NSRect)frame;

- (void) reloadData;

@property (nonatomic, readonly) NSMutableArray<CWGraphicPlotViewDataSource>* dataSources;
@property (nonatomic, assign)	id<CWGraphicPlotViewDelegate>	delegate;		// a weak reference
@property (nonatomic, assign)	double							precision;

@end
