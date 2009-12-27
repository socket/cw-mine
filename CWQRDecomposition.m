//
//  CWQRDecomposition.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/24/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWQRDecomposition.h"


@implementation CWQRDecomposition

- (id) initWithMatrix:(CWMatrix*)matrix {
	if ( self = [super initWithMatrix:matrix] ) {
		_QR = [matrix copyAsArray];
		_RDiag = calloc(_n, sizeof(double));
	}
	return self;
}

- (void) decompose {
	// main loop
	for (int k = 0; k < _n; k++) {
		double nrm = 0;		// compute 2-norm of k-th column without under/overflow
		for (int i = k; i < _m; i++) {
			nrm = hypot(nrm, MXE(_QR, i, k) );
		}
		
		if ( nrm != 0.0 ) { // form householder vector
			if ( MXE(_QR, k, k) < 0 ) {
				nrm = -nrm;
			}
			for (int i = k; i < _m; i++) {
				MXE(_QR, i, k) /= nrm;
			}
			MXE(_QR, k, k) += 1.0;
			
			// apply transformation to remaining columns
			for (int j = k+1; j < _n; j++ ) {
				double s = 0.0;
				for (int i = k; i < _m; i++) {
					s += MXE(_QR, i, k) * MXE(_QR, i, j);
				}
				s = -s/MXE(_QR, k, k);
				for (int i = k; i < _m; i++) {
					MXE(_QR, i, j) += s * MXE(_QR, i, k);
				}
			}
		}
		_RDiag[k] = -nrm;
	}
}

- (BOOL) isFullRank {
	for (int j = 0; j < _n; j++) {
		if (_RDiag[j] == 0)
			return NO;
	}
	return YES;
}

//Lower trapezoidal matrix whose columns define the reflections
- (CWMatrix*) matrixH {
	CWMatrix* H = [CWMatrix matrixWithRows:_m columns:_n];
	for (int i = 0; i < _m; i++) {
		for (int j = 0; j < _n; j++) {
			if (i >= j) {
				[H setValue:MXE(_QR,i,j) row:i column:j];
			} else {
				[H setValue:0 row:i column:j];
			}
		}
	}
	return H;
}

// Return the upper triangular factor
- (CWMatrix*) matrixR {
	CWMatrix* R = [CWMatrix matrixWithRows:_n columns:_n];
	for (int i = 0; i < _n; i++) {
		for (int j = 0; j < _n; j++) {
			if (i < j) {
				[R setValue:MXE(_QR,i,j) row:i column:j];
			} else if (i == j) {
				[R setValue:_RDiag[i] row:i column:j];
			} else {
				[R setValue:0 row:i column:j];
			}
		}
	}
	return R;
}

- (CWMatrix*) matrixQ {
	CWMatrix* Q = [CWMatrix matrixWithRows:_m columns:_n];
	for (int k = _n-1; k >= 0; k--) {
		for (int i = 0; i < _m; i++) {
			[Q setValue:0.0 row:i column:k];
		}
		[Q setValue:1.0 row:k column:k];
		
		for (int j = k; j < _n; j++) {
			if (MXE(_QR,k,k) != 0) {
				double s = 0.0;
				for (int i = k; i < _m; i++) {
					s += MXE(_QR,i,k)*[Q valueForRow:i column:j];
				}
				s = -s/MXE(_QR,k,k);
				for (int i = k; i < _m; i++) {
					double v = [Q valueForRow:i column:j] + s*MXE(_QR,i,k);
					[Q setValue:v row:i column:j];
				}
			}
		}
	}
	return Q;
}

- (CWMatrix*) solveWithMatrix:(CWMatrix*)B {
	if ([B rows] != _m) {
		[[NSAlert alertWithMessageText:@"Unable to solve" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Matrix row dimensions must agree"] runModal];
		return nil;
	}
	
	if (![self isFullRank]) {
		[[NSAlert alertWithMessageText:@"Unable to solve" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Matrix is rank deficient"] runModal];
		return nil; 
	}
	
	int nx = [B columns];
	double* X = [B copyAsArray];
	
	// Compute Y = transpose(Q)*B
	for (int k = 0; k < _n; k++) {
		for (int j = 0; j < nx; j++) {
			double s = 0.0; 
			for (int i = k; i < _m; i++) {
				s += MXE(_QR, i, k) * MXE1(X,nx,i,j);
			}
			s = -s/MXE(_QR, k, k);
			for (int i = k; i < _m; i++) {
				MXE1(X,nx,i,j) += s*MXE(_QR, i, k);
			}			
		}
	}
	// Solve R*X = Y;
	for (int k = _n-1; k >= 0; k--) {
		for (int j = 0; j < nx; j++) {
			MXE1(X,nx,k,j) /= _RDiag[k];
		}
		for (int i = 0; i < k; i++) {
			for (int j = 0; j < nx; j++) {
				MXE1(X,nx,i,j) -= MXE1(X,nx,k,j)*MXE(_QR, i, k);
			}
		}
	}
	
	CWMatrix* R = [[CWMatrix alloc] initWithData:X rows:_n columns:nx];
	return [R submatrixWithInitialRow:0 finalRow:(_n-1) initialColumn:0 finalColumn:nx-1];
}

- (NSString*) description {
	return @"QR Decomposition";
}

- (void) dealloc {
	if (_QR)
		free(_QR);
	if ( _RDiag )
		free(_RDiag);
	
	[super dealloc];
}
@end
