//
//  CWDecompositionController.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/20/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrix.h"
#import "CWMatrixTableView.h"
#import "CWMethodOperation.h"
#import "CWMatrixLUDecOperation.h"

@interface CWDecompositionController : NSWindowController<NSTextFieldDelegate, CWOperationDelegate, NSComboBoxDelegate> {
	@private
	CWMatrixTableView*		_srcMatrixView;
	CWMatrixTableView*		_resultMatrixView;
	
	NSTextField*			_rankTextField;
	NSTextField*			_resultTextField;
	
	NSComboBox*				_methodComboBox;
	NSComboBox*				_displayKeyComboBox;
	NSButton*				_execButton;
	NSProgressIndicator*	_progressIndicator;
	CWMethodOperation*		_operation;
	NSArray*				_outputKeys;
}

@property (nonatomic, retain) IBOutlet CWMatrixTableView*	srcMatrixView;
@property (nonatomic, retain) IBOutlet CWMatrixTableView*	resultMatrixView;
@property (nonatomic, retain) IBOutlet NSComboBox*			methodComboBox;
@property (nonatomic, retain) IBOutlet NSComboBox*			displayKeyComboBox;
@property (nonatomic, retain) IBOutlet NSProgressIndicator* progressIndicator;
@property (nonatomic, retain) IBOutlet NSButton*			execButton;

@property (nonatomic, retain) IBOutlet NSTextField*	rankTextField;

@property (nonatomic, retain) IBOutlet NSTextField*	resultTextField;

- (IBAction) makeRandomValues:(id)sender;
- (IBAction) makeDefaultValues:(id)sender;
- (IBAction) doUpdateSourceMatrix:(id)sender;

- (IBAction) calculate:(id)sender;


@end
