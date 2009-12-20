//
//  CWMatrixLUDecomposition.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/17/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixLUDecOperation.h"

NSString* const kLMatrix = @"l_matrix";
NSString* const kUMatrix = @"u_matrix";

@implementation CWMatrixLUDecOperation
@synthesize srcMatrix = _srcMatrix;

// Computing the LU decomposition using either of these algorithms requires 2n^3 / 3 floating point operations, 
// ignoring lower order terms. 
- (id) initWithMatrix:(CWMatrix*)matrix {
	if ( self = [self init] ) {
		self.srcMatrix = matrix;
	}
	return self;
}

- (void) main {
	unsigned int rank = [_srcMatrix rank];
	CWMatrix* u_matrix = [[_srcMatrix copy] autorelease]; // A(0) -- U-matrix
	CWMatrix* l_matrix = [CWMatrix matrixWithRows:rank andColumns:rank];
	
	// get L- and U- matrices
	for ( int n = 0; n < rank; ++n ) { // iterations
		for ( int i = n+1; i < rank; ++i ) {
			double a_in = [u_matrix valueForRow:i column:n];
			double a_nn = [u_matrix valueForRow:n column:n];
			double lin_multiplier = -a_in / a_nn;
			[l_matrix setValue:-lin_multiplier row:i column:n];
			
			for ( int j = n; j < rank; ++j ) {
				double a_nj = [u_matrix valueForRow:n column:j];
				double a_ij = [u_matrix valueForRow:i column:j];
				double a_res = a_ij + a_nj*lin_multiplier;			
				[u_matrix setValue:a_res row:i column:j];
			}
		}
	}
	// fill main diag of L-Matrix
	for ( int n=0; n<rank; ++n ) {
		[l_matrix setValue:1.0 row:n column:n];
	}
	
	[self.output setValue:u_matrix forKey:@"u_matrix"];
	[self.output setValue:l_matrix forKey:@"l_matrix"];
	
	[self succceed];
}

- (void) dealloc {
	[_srcMatrix release];
	[super dealloc];
}

@end
