//
//  CWMatrixLUDecomposition.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/17/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMethodOperation.h"
#import "CWMatrix.h"

extern NSString* const kLMatrix;
extern NSString* const kUMatrix;

@interface CWMatrixLUDecOperation : CWMethodOperation {
	CWMatrix*		_srcMatrix;
}

@property (nonatomic, retain) CWMatrix* srcMatrix;

- (id) initWithMatrix:(CWMatrix*)matrix;

@end
