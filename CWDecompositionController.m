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
#import "NSArray+ComboDataSource.h"
#import "CWMethodDataSource.h"

@interface CWDecompositionController ()

- (void)updateSourceMatrix;

@property (nonatomic, retain) NSArray* outputKeys;
@property (nonatomic, readonly) NSInteger selectedRank;
@property (nonatomic, retain) CWMethodOperation* operation;
@end


@implementation CWDecompositionController

@synthesize srcMatrixView		= _srcMatrixView, resultMatrixView = _resultMatrixView;
@synthesize rankTextField		= _rankTextField;
@synthesize methodComboBox		= _methodComboBox;
@synthesize displayKeyComboBox	= _displayKeyComboBox;
@synthesize progressIndicator	= _progressIndicator;
@synthesize operation			= _operation;
@synthesize execButton			= _execButton;
@synthesize outputKeys			= _outputKeys;
@synthesize resultTextField		= _resultTextField;

- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		
	}
	return self;
}

- (void) awakeFromNib {
	
}

- (void) windowDidLoad {
	[self makeRandomValues:nil];
	
	[_methodComboBox setDataSource:[CWMethodDataSource useableMethodArray]];
	[_methodComboBox reloadData];
	
	[_execButton setEnabled: ([_methodComboBox indexOfSelectedItem] >= 0)];
}

- (IBAction) doUpdateSourceMatrix:(id)sender {
	[self updateSourceMatrix];
}

- (void) updateSourceMatrix {
	if ( self.selectedRank != _srcMatrixView.matrix.rank ) {
		_srcMatrixView.matrix = [[CWMatrix matrixWithRows:self.selectedRank columns:self.selectedRank] 
								 addMatrix:_srcMatrixView.matrix];
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
	Class selClass = [[CWMethodDataSource useableMethodArray] objectAtIndex:[_methodComboBox indexOfSelectedItem]];
	CWMethodOperation* op = [[selClass alloc] init];
	[op.inputs setValue:_srcMatrixView.matrix forKey:kSourceMatrix];
	
	op.delegate = self;
	[[CWMethodExecutor sharedInstance] addOperation:op];
	[_progressIndicator startAnimation:self];
	
	[_displayKeyComboBox setDataSource:nil];
	[_displayKeyComboBox reloadData];
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
	[_rankTextField setIntValue:[self selectedRank]];
	[self updateSourceMatrix]; 

	return YES;
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
	BOOL enabled = ([_methodComboBox indexOfSelectedItem] >= 0);
	
	[_execButton setEnabled: enabled];
	

	if ( enabled ) {
		Class selClass = [[CWMethodDataSource useableMethodArray] objectAtIndex:[_methodComboBox indexOfSelectedItem]];
		self.outputKeys = [selClass outputKeys];
		[_displayKeyComboBox setDataSource:self.outputKeys];
		[_displayKeyComboBox reloadData];
	}

	// change data in display
	if ( _operation && ( [_displayKeyComboBox indexOfSelectedItem] >= 0 ) ) {
		NSString* key = [self.outputKeys objectAtIndex:[_displayKeyComboBox indexOfSelectedItem]];
		if ( ! key ) 
			return;
		
		id obj = [_operation.outputs valueForKey:key];
		if ( [obj isKindOfClass:[CWMatrix class]] ) {
			_resultMatrixView.matrix = obj;
		}
		else if ( [obj isKindOfClass:[NSNumber class]] ){
			
		}
	}
}

- (void) dealloc {
	self.operation = nil;
	self.outputKeys = nil;
	
	[_resultTextField release];
	[_execButton release];
	[_methodComboBox release];
	[_displayKeyComboBox release];
	[_progressIndicator release];
	[_srcMatrixView release];
	[_resultMatrixView release];
	[_rankTextField release];
	[super dealloc];
}
@end
