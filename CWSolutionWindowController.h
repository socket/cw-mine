//
//  CWSolutionWindowController.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/9/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrixTableView.h"

@interface CWSolutionWindowController : NSWindowController<NSTextFieldDelegate, NSComboBoxDelegate> {
	@private
	CWMatrixTableView*		_aMatrixTableView;
	CWMatrixTableView*		_bMatrixTableView;
	CWMatrixTableView*		_resultMatrixTableView;
		
	NSComboBox*				_algComboBox;
	NSTextField*			_textField;
	
	NSArray*				_methods;
}

- (IBAction) solve:(id)sender;
- (IBAction) revertToDefaults:(id)sender;

@property (nonatomic, retain) IBOutlet CWMatrixTableView* aMatrixTableView;
@property (nonatomic, retain) IBOutlet CWMatrixTableView* bMatrixTableView;
@property (nonatomic, retain) IBOutlet CWMatrixTableView* resultMatrixTableView;
@property (nonatomic, retain) IBOutlet NSTextField*	 textField;
@property (nonatomic, retain) IBOutlet NSComboBox*			algComboBox;

@end
