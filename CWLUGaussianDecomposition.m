//
//  CWLUGaussianDecomposition.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/25/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWLUGaussianDecomposition.h"


@implementation CWLUGaussianDecomposition

- (void) decompose {
	for (int k = 0; k < _n; k++) {
		// Find pivot.
		int p = k;
		for (int i = k+1; i < _m; i++) {
			if ( ABS(MXE(_LU, i, k)) > ABS(MXE(_LU, p, k)) ) {
				p = i;
			}
		}
		// Exchange if necessary.
		if (p != k) {
			for (int j = 0; j < _n; j++) {
				double t = MXE(_LU, p, j); 
				MXE(_LU, p, j) = MXE(_LU, k, j); 
				MXE(_LU, k, j) = t;
			}
			
			int t = _piv[p]; 
			_piv[p] = _piv[k]; 
			_piv[k] = t;
			
			_pivsign = -_pivsign;
		}
		// Compute multipliers and eliminate k-th column.
		if (MXE(_LU, k, k) != 0.0) {
			for (int i = k+1; i < _m; i++) {
				MXE(_LU, i, k) /= MXE(_LU, k, k);
				for (int j = k+1; j < _n; j++) {
					MXE(_LU, i, j) -= MXE(_LU, i, k) * MXE(_LU, k, j);
				}
			}
		}
	}	
}

@end
