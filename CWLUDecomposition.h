//
//  CWLUDecomposition.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/25/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrixDecomposition.h"

@interface CWLUDecomposition : CWMatrixDecomposition {
	@protected
	int		_pivsign;
	int*	_piv;
	double* _LU;
}

- (BOOL) nonsingular;

- (CWMatrix*) matrixL;
- (CWMatrix*) matrixU;

- (NSArray*) pivots;

@end
