//
//  CWQRDecomposition.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/24/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrix.h"

@interface CWQRDecomposition : NSObject {
	@private
	CWMatrix* _matrix;
	double*	  _QR;
	double*   _RDiag;
	int		  _m;
	int		  _n;
}

- (id) initWithMatrix:(CWMatrix*)matrix;

- (void) decompose;

- (CWMatrix*) matrixQ;
- (CWMatrix*) matrixR;
- (CWMatrix*) matrixH;		// householder vectors
- (BOOL) isFullRank;
- (CWMatrix*) solveWithMatrix:(CWMatrix*)B;

@end
