//
//  CWSolutionWindowController.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/9/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWSolutionWindowController.h"
#import "CWMatrixInitializer.h"
#import "CWLUGaussianDecomposition.h"
#import "CWLUDecomposition.h"
#import "NSArray+ComboDataSource.h"
#import "CWQRDecomposition.h"

@implementation CWSolutionWindowController

@synthesize aMatrixTableView = _aMatrixTableView;
@synthesize bMatrixTableView = _bMatrixTableView;
@synthesize resultMatrixTableView = _resultMatrixTableView;
@synthesize textField = _textField;
@synthesize algComboBox = _algComboBox;

- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		
	}
	return self;
}

- (void) windowDidLoad {
	int rank = [_textField intValue];
	
	[self revertToDefaults:nil];
	_resultMatrixTableView.matrix	= [CWMatrix matrixWithRows:rank columns:1];
	
	[_aMatrixTableView reloadData];
	
	_methods = [[NSArray arrayWithObjects:[CWLUDecomposition class], [CWLUGaussianDecomposition class],
				 [CWQRDecomposition class], nil] retain];
	
	[_algComboBox setDelegate:self];
	[_algComboBox setDataSource:_methods];
	[_algComboBox reloadData];
	
	[_algComboBox selectItemAtIndex:0];
}

- (void) awakeFromNib {
	
}

- (IBAction) solve:(id)sender {
	if ( [_algComboBox indexOfSelectedItem] < 0 ) {
		return;
	}
	
	Class dcClass = [_methods objectAtIndex:[_algComboBox indexOfSelectedItem]];
	CWMatrixDecomposition* dc = [[dcClass alloc] initWithMatrix:_aMatrixTableView.matrix];
	[dc decompose];
	CWMatrix* resultMatrix = [dc solveWithMatrix:_bMatrixTableView.matrix];
	_resultMatrixTableView.matrix = resultMatrix;
	[dc release];
}

- (IBAction) revertToDefaults:(id)sender {
	int rank = [_textField intValue];
	
	_aMatrixTableView.matrix = [CWMatrixInitializer orderedMatrixWithRank:rank];
	_bMatrixTableView.matrix = [CWMatrix matrixWithRows:rank columns:1];
}

- (BOOL) control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
	int rank = [_textField intValue];
	if ( rank != [_aMatrixTableView.matrix rank] ) {
		_aMatrixTableView.matrix = [[CWMatrix matrixWithRows:rank columns:rank] addMatrix:_aMatrixTableView.matrix];
		_bMatrixTableView.matrix = [[CWMatrix matrixWithRows:rank columns:1] addMatrix:_bMatrixTableView.matrix];
	}
	
	return YES;
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
	
}	
	
- (void) dealloc {
	[_aMatrixTableView release];
	[_bMatrixTableView release];
	[_textField release];
	[_methods release];
	[_algComboBox release];
	[_resultMatrixTableView release];
	
	[super dealloc];
}

@end
