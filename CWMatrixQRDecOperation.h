//
//  CWMatrixQRDecOperation.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/23/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMethodOperation.h"
#import "CWMatrix.h"

@interface CWMatrixQRDecOperation : CWMethodOperation {

}

- (CWMatrix*) srcMatrix;
- (id) initWithMatrix:(CWMatrix*)matrix;

@end
