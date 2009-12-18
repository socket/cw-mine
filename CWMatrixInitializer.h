//
//  CWMatrixInitializer.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/27/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrix.h"


@interface CWMatrixInitializer : NSObject {

}

+ (double) cCoeffForRank:(NSUInteger)rank qCoeff:(double)qCoeff;
+ (CWMatrix*) matrixWithRank:(NSUInteger)rank qCoeff:(double)qCoeff;
+ (CWMatrix*) randomMatrixWithRank:(NSUInteger)rank;

@end
