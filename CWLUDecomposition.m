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

/* for (int j = 0; j < n; j++) {
 
 // Make a copy of the j-th column to localize references.
 
 for (int i = 0; i < m; i++) {
 LUcolj[i] = LU[i][j];
 }
 
 // Apply previous transformations.
 
 for (int i = 0; i < m; i++) {
 LUrowi = LU[i];
 
 // Most of the time is spent in the following dot product.
 
 int kmax = Math.min(i,j);
 double s = 0.0;
 for (int k = 0; k < kmax; k++) {
 s += LUrowi[k]*LUcolj[k];
 }
 
 LUrowi[j] = LUcolj[i] -= s;
 }*/

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

- (BOOL) isNonsingular {
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

- (void) dealloc {
	if ( _LU )
		free( _LU );
	
	if ( _piv )
		free( _piv );
	
	[super dealloc];
}
@end
