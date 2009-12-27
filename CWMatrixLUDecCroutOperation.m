//
//  CWMatrixLUDecCroutOperation.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/25/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixLUDecCroutOperation.h"
#import "CWLUDecomposition.h"
#import "CWMatrixInitializer.h"

@implementation CWMatrixLUDecCroutOperation

- (BOOL) process {
	CWMatrix* matrix;
	unsigned int rank = [self.srcMatrix rank];
	if ( [_inputs valueForKey:kMatrixRank] ) {
		rank = [[_inputs valueForKey:kMatrixRank] intValue];
		if ( rank == 0 )
			return YES;
		
		matrix = [CWMatrixInitializer matrixWithRank:rank qCoeff:rank];
	}
	else {
		matrix = [[self.srcMatrix copy] autorelease]; // A(0) -- U-matrix
	}
	
	CWLUDecomposition* dc = [[CWLUDecomposition alloc] initWithMatrix:matrix];
	[dc decompose];
	
	[self.outputs setValue:[dc matrixL] forKey:kLMatrix];
	[self.outputs setValue:[dc matrixU] forKey:kUMatrix];
	
	[dc release];
	
	return YES;
}

+ (NSString*) description {
	return @"LU-decomposition (Crout-Doolittle)";
}

@end
