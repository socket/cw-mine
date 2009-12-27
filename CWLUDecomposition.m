//
//  CWLUDecomposition.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/25/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWLUDecomposition.h"


@implementation CWLUDecomposition

- (id) initWithMatrix:(CWMatrix*)matrix {
	if ( self = [super initWithMatrix:matrix] ) {
		_LU = [matrix copyAsArray];
		_piv = calloc(_m, sizeof(int));
		for (int i = 0; i < _m; i++) {
			_piv[i] = i;
		}
		_pivsign = 1;
		
	}
	return self;
}

- (void) decompose {
	double* LUrowi;
	double* LUcolj = calloc(_m, sizeof(double));
	
	for( int j = 0; j < _n; ++j ) {
		for ( int i = 0; i < _m; ++i ) {
			LUcolj[i] = MXE(_LU, i, j);
		}
		
		for ( int i = 0; i < _m; ++i ) {
			LUrowi = ROW(_LU, i);
			
			int kmax = MIN(i, j);
			double s = 0.0;
			
			for ( int k = 0; k < kmax; k++ ) {
				s += LUrowi[k] * LUcolj[k];
			}
			LUrowi[j] = LUcolj[i] -= s;
		}
		
		int p = j;
		for (int i = j+1; i < _m; i++) {
            if (ABS(LUcolj[i]) > ABS(LUcolj[p])) {
				p = i;
            }
		}
		
		if (p != j) {
            for (int k = 0; k < _n; k++) {
				double t = MXE(_LU, p, k); 
				MXE(_LU, p, k) = MXE(_LU, j, k); 
				MXE(_LU, j, k) = t;
            }
			
            int k = _piv[p]; 
			_piv[p] = _piv[j]; 
			_piv[j] = k;
            
			_pivsign = -_pivsign;
		}
		
		// Compute multipliers.
		if (j < _m & MXE(_LU, j, j) != 0.0) {
            for (int i = j+1; i < _m; i++) {
				MXE(_LU, i, j) /= MXE(_LU, j, j);
            }
		}
	}
}

- (BOOL) nonsingular {
	for (int j = 0; j < _n; j++) {
		if (MXE(_LU, j, j) == 0)
			return NO;
	}
	return YES;
}

-(CWMatrix*) matrixL {
	CWMatrix* L = [CWMatrix matrixWithRows:_m columns:_n];
	for (int i = 0; i < _m; i++) {
		for (int j = 0; j < _n; j++) {
			if (i > j) {
				[L setValue:MXE(_LU, i, j) row:i column:j];
			} else if (i == j) {
				[L setValue:1.0 row:i column:j];
			} else {
				[L setValue:0.0 row:i column:j];
			}
		}
	}
	return L;
}

-(CWMatrix*) matrixU {
	CWMatrix* U = [CWMatrix matrixWithRows:_n columns:_n];
	for (int i = 0; i < _n; i++) {
		for (int j = 0; j < _n; j++) {
            if (i <= j) {
				[U setValue:MXE(_LU, i, j) row:i column:j];
            } else {
				[U setValue:0.0 row:i column:j];
            }
		}
	}
	return U;	
}

- (NSArray*) pivots {
	NSMutableArray* pivotArray = [NSMutableArray array];
	for (int i=0; i<_m; i++) {
		[pivotArray addObject:[NSNumber numberWithInt:_piv[i]]];
	}
	return pivotArray;
}

- (CWMatrix*) solveWithMatrix:(CWMatrix*)B {
	if ([B rows] != _m) {
		[[NSAlert alertWithMessageText:@"Unable to solve" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Row count does not match"] runModal];
		return nil;
	}
	
	if (![self nonsingular]) {
		[[NSAlert alertWithMessageText:@"Unable to solve" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Matrix is singular"] runModal];
		
		return nil; // matrix is singular
	}
	
	// Copy right hand side with pivoting
	int nx = [B columns];
	CWMatrix* X = [B submatrixWithRows:[self pivots] initialColumn:0 finalColumn:nx-1];
	int rx = [X rows];
	
	// Solve L*Y = B(piv,:)
	/*
	for (int k = 0; k < _n; k++) {
		for (int i = k+1; i < _n; i++) {
            for (int j = 0; j < nx; j++) {
				MXE1(X.data, rx, i, j) -= MXE1(X.data, rx, k, j) * MXE(_LU, i, k);
            }
		}
	}
	 */
	// Solve U*X = Y;
	/*
	for (int k = _n-1; k >= 0; k--) {
		for (int j = 0; j < nx; j++) {
			MXE1(X.data, rx, k, j) /= MXE(_LU, k, k);
		}
		for (int i = 0; i < k; i++) {
            for (int j = 0; j < nx; j++) {
				MXE1(X.data, rx, i, j) -= MXE1(X.data, rx, k, j) * MXE(_LU, i ,k);
            }
		}
	}*/
	return X;
}

- (NSString*) description {
	return @"LU Decomposition (Crout)";
}

- (void) dealloc {
	if ( _LU )
		free( _LU );
	
	if ( _piv )
		free( _piv );
	
	[super dealloc];
}

@end
