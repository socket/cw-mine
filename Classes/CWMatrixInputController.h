//
//  CWMatrixInputController.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrixTableView.h"

@interface CWMatrixInputController : NSWindowController<NSTextFieldDelegate> {
	@private
	CWMatrixTableView*	_tableView;
	NSTextField*		_qValTextField;
	NSTextField*		_nValTextField;
	NSTextField*		_cValTextField;
}

@property (nonatomic, retain) IBOutlet CWMatrixTableView* tableView;
@property (nonatomic, retain) IBOutlet NSTextField* qValTextField;
@property (nonatomic, retain) IBOutlet NSTextField* nValTextField;
@property (nonatomic, retain) IBOutlet NSTextField* cValTextField;

- (IBAction) revertMatrix:(id)sender;
- (IBAction) commitMatrix:(id)sender;
- (void) updateMatrix;

@end
