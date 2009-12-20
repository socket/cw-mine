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

@interface CWDecompositionController : NSWindowController<NSTextFieldDelegate, CWOperationDelegate> {
	@private
	CWMatrixTableView*	_srcMatrixView;
	CWMatrixTableView*	_lMatrixView;
	CWMatrixTableView*	_uMatrixView;
	NSTextField*		_rankTextField;
}

@property (nonatomic, retain) IBOutlet CWMatrixTableView*	srcMatrixView;
@property (nonatomic, retain) IBOutlet CWMatrixTableView*	lMatrixView;
@property (nonatomic, retain) IBOutlet CWMatrixTableView*	uMatrixView;
@property (nonatomic, retain) IBOutlet NSTextField*	rankTextField;

- (IBAction) makeRandomValues:(id)sender;
- (IBAction) makeDefaultValues:(id)sender;
- (IBAction) doUpdateSourceMatrix:(id)sender;

- (IBAction) calculate:(id)sender;


@end
