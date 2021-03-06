//
//  CWGraphicWindowController.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWGraphPlotView.h"
#import "CWMethodDataSource.h"
#import "CWMethodOperation.h"
#import "CWAddPlotWindowController.h"

@interface CWGraphicWindowController : NSWindowController<	NSTableViewDelegate, 
															NSTextFieldDelegate,
															NSComboBoxDelegate,
															NSTableViewDataSource,
															CWGraphPlotViewDelegate,
															CWOperationDelegate>
{
	@private
	CWGraphPlotView*		_graphView;
	NSTableView*			_graphListTableView;
	NSSegmentedControl*		_segmentedControl;
	
	double					_rangeBegin;
	double					_rangeEnd;
	double					_rangeStep;
	
	NSTextField*			_rangeBeginText;
	NSTextField*			_rangeEndText;
	
	NSTimer*				_timer;
	NSArray*				_methodsDataSource;					// list of all available methods
	NSMutableArray*			_methodsSelected;			// list of current methods
}

- (IBAction) segmentedSelector:(id)sender;

- (IBAction) updateGraphRanges:(id)sender;
@property (nonatomic, retain) IBOutlet NSTableView*			graphListTableView;
@property (nonatomic, retain) IBOutlet CWGraphPlotView*		graphView;
@property (nonatomic, retain) IBOutlet NSSegmentedControl*		segmentedControl;
@property (nonatomic, retain) IBOutlet NSTextField*			rangeBeginText;
@property (nonatomic, retain) IBOutlet NSTextField*			rangeEndText;

@end
