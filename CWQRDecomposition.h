//
//  CWQRDecomposition.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/24/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrix.h"
#import "CWMatrixDecomposition.h"

@interface CWQRDecomposition : CWMatrixDecomposition {
	@private
	double*	  _QR;
	double*   _RDiag;
}

- (CWMatrix*) matrixQ;
- (CWMatrix*) matrixR;
- (CWMatrix*) matrixH;		// householder vectors
- (BOOL) isFullRank;

@end
