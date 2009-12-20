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

@interface CWGraphicWindowController : NSWindowController<NSTableViewDelegate> {
	@private
	CWGraphPlotView*		_graphView;
	NSTableView*			_graphListTableView;
	NSButton*				_addButton;
	NSButton*				_removeButton;
	
	NSArray*				_methodsDataSource;					// list of all available methods
	NSMutableArray*			_methodsSelected;			// list of current methods
}

- (IBAction) addMethod:(id)sender;
- (IBAction) removeMethod:(id)sender;

@property (nonatomic, retain) NSTableView*	graphListTableView;
@property (nonatomic, retain) NSButton*		addButton;
@property (nonatomic, retain) NSButton*		removeButton;


@end
