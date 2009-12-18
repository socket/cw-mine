//
//  CWMatrixLUDecomposition.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/17/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMethod.h"
#import "CWMatrix.h"

@interface CWMatrixLUDecomposition : CWMethod {
	CWMatrix* _srcMatrix;
	CWMatrix* _destMatrix;
}

@property (nonatomic, retain) CWMatrix* srcMatrix;
@property (nonatomic, retain) CWMatrix* destMatrix;

@end
