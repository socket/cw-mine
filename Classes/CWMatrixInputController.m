//
//  CWMatrixInputController.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixInputController.h"
#import "CWMatrixInitializer.h"
#import "CWMatrixDataSource.h"
#import "CWMatrix.h"

@implementation CWMatrixInputController

@synthesize tableView = _tableView;
@synthesize qValTextField = _qValTextField;
@synthesize nValTextField = _nValTextField;
@synthesize cValTextField = _cValTextField;

- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		
	}
	
	return self;
}

- (void) awakeFromNib {
	_qValTextField.delegate = self;
	_nValTextField.delegate = self;
}

- (void) windowDidLoad {
	[self updateMatrix];
}

- (void) updateMatrix {
	uint rank = [_nValTextField intValue];
	double qCoeff = [_qValTextField doubleValue];
	
	if ( rank < 1 ) {	
		rank = 1;
		[_nValTextField setIntValue:rank];
	}
	
	[_cValTextField setDoubleValue:[CWMatrixInitializer cCoeffForRank:rank qCoeff:qCoeff]];
	
	self.tableView.matrix = [CWMatrixInitializer matrixWithRank:rank qCoeff:qCoeff];
	
	[self.tableView reloadData];
}

- (BOOL) control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
	[self updateMatrix]; 
	
	return YES;
}

#pragma mark Button actions
- (IBAction) revertMatrix:(id)sender {
	
}

- (IBAction) commitMatrix:(id)sender {
	
}


- (void) dealloc {
	self.tableView = nil;
	self.qValTextField = nil;
	self.nValTextField = nil;
	self.cValTextField = nil;
	
	[super dealloc];
}
@end
