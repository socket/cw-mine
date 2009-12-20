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

@end


@implementation CWDecompositionController
@synthesize srcMatrixView = _srcMatrixView, lMatrixView = _lMatrixView, uMatrixView = _uMatrixView;
@synthesize rankTextField = _rankTextField;


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
	_srcMatrixView.matrix = [CWMatrixInitializer matrixWithRank:self.selectedRank qCoeff:0.994];;
}

- (IBAction) calculate:(id)sender {
	NSLog( @"SRC:\n %@", [_srcMatrixView.matrix description] );
	CWMatrixLUDecOperation* op = [[[CWMatrixLUDecOperation alloc] initWithMatrix:_srcMatrixView.matrix] autorelease];
	op.delegate = self;
	[[CWMethodExecutor sharedInstance] addOperation:op];
}

#pragma mark operation delegate
-(void)operationSucceeded:(CWMethodOperation*)operation {
	if ( [operation isKindOfClass:[CWMatrixLUDecOperation class]] ) {
		_lMatrixView.matrix = [operation.outputs valueForKey:kLMatrix];
		_uMatrixView.matrix = [operation.outputs valueForKey:kUMatrix];

		NSLog( @"L:\n %@", [_lMatrixView.matrix description] );
		NSLog( @"U:\n %@", [_uMatrixView.matrix description] );
		NSLog( @"LU:\n %@", [_lMatrixView.matrix multiplyByMatrix:_uMatrixView.matrix] );
	}
	else if ( 0 ) {
		
	}
}

-(void)operationFailed:(CWMethodOperation*)operation {
	[NSAlert alertWithError:operation.error];
}

#pragma mark -
#pragma mark delegates
- (BOOL) control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
	[self updateSourceMatrix]; 
	
	return YES;
}

- (void) dealloc {
	[_srcMatrixView release];
	[_lMatrixView release];
	[_uMatrixView release];
	[_rankTextField release];
	[super dealloc];
}
@end
