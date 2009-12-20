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

@interface CWGraphicWindowController : NSWindowController<	NSTableViewDelegate, 
															NSTextFieldDelegate,
															NSComboBoxDelegate	>
{
	@private
	CWGraphPlotView*		_graphView;
	NSTableView*			_graphListTableView;
	
	NSArray*				_methodsDataSource;					// list of all available methods
	NSMutableArray*			_methodsSelected;			// list of current methods

	// add/edit method pane
	NSView*					_methodAddPane;
	NSComboBox*				_methodNameComboBox;
	NSComboBox*				_methodKeyComboBox;
	NSColorWell*			_methodColor;
	NSTextField*			_methodPrecision;
}

- (IBAction) segmentedSelector:(id)sender;

- (IBAction) addMethod:(id)sender;
- (IBAction) removeMethod:(id)sender;

- (IBAction) showSettings:(id)sender;
- (IBAction) hideSettings:(id)sender;

- (IBAction) showAddMethodPane:(id)sender;
- (IBAction) hideAddMethodPane:(id)sender;

@property (nonatomic, retain) IBOutlet NSTableView*			graphListTableView;
@property (nonatomic, retain) IBOutlet CWGraphPlotView*		graphView;

@property (nonatomic, retain) IBOutlet NSView*				methodAddPane;
@property (nonatomic, retain) IBOutlet NSComboBox*			methodNameComboBox;
@property (nonatomic, retain) IBOutlet NSComboBox*			methodKeyComboBox;
@property (nonatomic, retain) IBOutlet NSColorWell*			methodColor;
@property (nonatomic, retain) IBOutlet NSTextField*			methodPrecision;
@end
