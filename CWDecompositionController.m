//
//  CWDecompositionController.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/20/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWDecompositionController.h"
#import "CWMatrixInitializer.h"

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

- (void) updateSourceMatrix {
	if ( self.selectedRank != _srcMatrixView.matrix.rank ) {
		// FIXME: copy old values
		_srcMatrixView.matrix = [CWMatrix matrixWithRows:self.selectedRank andColumns:self.selectedRank];
	}
}

- (NSInteger) selectedRank {
	int rank = [_rankTextField intValue];
	return MIN( MAX(0, rank), 100 );
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
