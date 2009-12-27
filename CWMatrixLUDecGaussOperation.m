//
//  CWMatrixLUDecGaussOperation.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/27/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixLUDecGaussOperation.h"
#import "CWLUGaussianDecomposition.h"

@implementation CWMatrixLUDecGaussOperation


- (id) init {
	self = [super init];
	if (self != nil) {
		_decompositionClass = [CWLUGaussianDecomposition class];
	}
	return self;
}

+ (NSString*) description {
	return @"LU-decomposition (Gaussian)";
}
@end
