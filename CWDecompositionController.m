//
//  CWDecompositionController.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/20/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWDecompositionController.h"
#import "CWMatrixInitializer.h"
#import "CWMethodExecutor.h"

@interface CWDecompositionController ()

@property (nonatomic, readonly) NSInteger selectedRank;
- (void)updateSourceMatrix;

@property (nonatomic, retain) CWMethodOperation* operation;
@end


@implementation CWDecompositionController

@synthesize srcMatrixView		= _srcMatrixView, resultMatrixView = _resultMatrixView;
@synthesize rankTextField		= _rankTextField;
@synthesize methodComboBox		= _methodComboBox;
@synthesize displayKeyComboBox	= _displayKeyComboBox;
@synthesize progressIndicator	= _progressIndicator;
@synthesize operation			= _operation;

- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		
	}
	return self;
}

- (void) awakeFromNib {
	
}

- (void) windowDidLoad {
	[self makeRandomValues:nil];
}

- (IBAction) doUpdateSourceMatrix:(id)sender {
	[self updateSourceMatrix];
}

- (void) updateSourceMatrix {
	if ( self.selectedRank != _srcMatrixView.matrix.rank ) {
		// FIXME: copy old values
		_srcMatrixView.matrix = [CWMatrix matrixWithRows:self.selectedRank columns:self.selectedRank];
	}
}

- (NSInteger) selectedRank {
	int rank = [_rankTextField intValue];
	return MIN( MAX(0, rank), 10000 );
}

#pragma mark -
#pragma mark Actions
- (IBAction) makeRandomValues:(id)sender {
	_srcMatrixView.matrix = [CWMatrixInitializer randomMatrixWithRank:self.selectedRank];
}

- (IBAction) makeDefaultValues:(id)sender {
	_srcMatrixView.matrix = [CWMatrixInitializer matrixWithRank:self.selectedRank qCoeff:0.994];
}

- (IBAction) calculate:(id)sender {
	CWMatrixLUDecOperation* op = [[[CWMatrixLUDecOperation alloc] initWithMatrix:_srcMatrixView.matrix] autorelease];
	op.delegate = self;
	[[CWMethodExecutor sharedInstance] addOperation:op];
	[_progressIndicator animate:self];
}

#pragma mark operation delegate
-(void)operationSucceeded:(CWMethodOperation*)operation {
	self.operation = operation;
	[_progressIndicator stopAnimation:self];
	
	
}

-(void)operationFailed:(CWMethodOperation*)operation {
	[NSAlert alertWithError:operation.error];
	self.operation = nil;
	[_progressIndicator stopAnimation:self];
}

#pragma mark -
#pragma mark delegates
- (BOOL) control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
	[self updateSourceMatrix]; 
	
	return YES;
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {

}
- (void) dealloc {
	[_operation release];
	[_methodComboBox release];
	[_displayKeyComboBox release];
	[_progressIndicator release];
	[_srcMatrixView release];
	[_resultMatrixView release];
	[_rankTextField release];
	[super dealloc];
}
@end
