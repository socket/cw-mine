//
//  CWSolutionWindowController.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/9/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWSolutionWindowController.h"
#import "CWMatrixInitializer.h"

@implementation CWSolutionWindowController

@synthesize aMatrixTableView = _aMatrixTableView;
@synthesize bMatrixTableView = _bMatrixTableView;
@synthesize resultMatrixTableView = _resultMatrixTableView;
@synthesize textField = _textField;
@synthesize progressIndicator = _progressIndicator;
@synthesize algComboBox = _algComboBox;

- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		
	}
	return self;
}

- (void) windowDidLoad {
	[_progressIndicator setHidden:YES];
	
	int rank = 10;
	
	_aMatrixTableView.matrix		= [CWMatrixInitializer matrixWithRank:rank qCoeff:0.994];
	_bMatrixTableView.matrix		= [CWMatrix matrixWithRows:rank andColumns:1];
	_resultMatrixTableView.matrix	= [CWMatrix matrixWithRows:rank andColumns:1];
	
	[_aMatrixTableView reloadData];
}

- (void) awakeFromNib {
	
}

- (IBAction) solve:(id)sender {
	[_progressIndicator setHidden:NO];
	[_progressIndicator startAnimation:self];
}

- (IBAction) revertToDefaults:(id)sender {
	_aMatrixTableView.matrix		= [CWMatrixInitializer matrixWithRank:[_textField intValue] qCoeff:0.994];	
	[_aMatrixTableView reloadData];
}

- (BOOL) control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
	
	return YES;
}

- (void) dealloc {
	[_aMatrixTableView release];
	[_bMatrixTableView release];
	[_textField release];
	[_algComboBox release];
	[_progressIndicator release];
	[_resultMatrixTableView release];
	
	[super dealloc];
}

@end
