//
//  CWMatrixDecomposition.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/25/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrix.h"

@interface CWMatrixDecomposition : NSObject {
	@protected
	CWMatrix* _matrix;
	
	int		  _m;
	int		  _n;
}

+ (id) decomposeMatrix:(CWMatrix*)matrix;

- (id) initWithMatrix:(CWMatrix*)matrix;
- (void) decompose;
- (CWMatrix*) solveWithMatrix:(CWMatrix*)B;

#define MXE(m, i, j)	m[i*_m + j]
#define ROW(m, i)		&m[i*_m]
@end
