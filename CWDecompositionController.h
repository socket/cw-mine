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
	NSComboBox*				_methodComboBox;
	NSComboBox*				_displayKeyComboBox;
	NSProgressIndicator*	_progressIndicator;
	CWMethodOperation*		_operation;
}

@property (nonatomic, retain) IBOutlet CWMatrixTableView*	srcMatrixView;
@property (nonatomic, retain) IBOutlet CWMatrixTableView*	resultMatrixView;
@property (nonatomic, retain) IBOutlet NSComboBox*			methodComboBox;
@property (nonatomic, retain) IBOutlet NSComboBox*			displayKeyComboBox;
@property (nonatomic, retain) IBOutlet NSProgressIndicator* progressIndicator;

@property (nonatomic, retain) IBOutlet NSTextField*	rankTextField;

- (IBAction) makeRandomValues:(id)sender;
- (IBAction) makeDefaultValues:(id)sender;
- (IBAction) doUpdateSourceMatrix:(id)sender;

- (IBAction) calculate:(id)sender;


@end
