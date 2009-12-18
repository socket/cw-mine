//
//  CWMatrixInitializer.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/27/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixInitializer.h"

@implementation CWMatrixInitializer


+ (double) cCoeffForRank:(NSUInteger)rank qCoeff:(double)qCoeff {
	double cCoeff = 0;
	for ( int k = 0; k < rank; ++k ) {
		cCoeff += pow(qCoeff, 2*k);
	}
	return cCoeff;
}

+ (CWMatrix*) matrixWithRank:(NSUInteger)rank qCoeff:(double)qCoeff {
	CWMatrix* matrix = [CWMatrix matrixWithRows:rank andColumns:rank];
	double cCoeff = [self cCoeffForRank:rank qCoeff:qCoeff];
	
	for ( int i = 0; i < rank; ++i ) {
		for ( int j = 0; j < rank; ++j ) {
			double val = (i != j) ? cCoeff + (pow(qCoeff, i) + pow(qCoeff, j)) * rank : 
									cCoeff + 2*pow(qCoeff, i) + rank*rank;
			
			[matrix setValue:val row:i column:j];
		}
	}
	
	return matrix;
}
+ (CWMatrix*) randomMatrixWithRank:(NSUInteger)rank {
	CWMatrix* matrix = [CWMatrix matrixWithRows:rank andColumns:rank];
	
	for ( int i = 0; i < rank; ++i ) {
		for ( int j = 0; j < rank; ++j ) {			
			[matrix setValue:(arc4random()%100) row:i column:j];
		}
	}
	
	return matrix;
}

@end
