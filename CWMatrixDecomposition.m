//
//  CWMatrixDecomposition.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/25/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixDecomposition.h"


@implementation CWMatrixDecomposition

+ (id) decomposeMatrix:(CWMatrix*)matrix {
	id m = [[[self class] alloc] initWithMatrix:matrix];
	[m decompose];
	return [m autorelease];
}

- (id) initWithMatrix:(CWMatrix*)matrix {
	if ( self = [self init] ) {
		_m = matrix.rows;
		_n = matrix.columns;
		_matrix = [matrix retain];
	}
	return self;
}

- (void) decompose {
	NSAssert(0, @"Calling this class is mean");
}

- (CWMatrix*) solveWithMatrix:(CWMatrix*)B {
	
	return B;
}

- (NSString*) description {
	return @"Generic decomposition class";
}

- (void) dealloc {
	[_matrix release];
	[super dealloc];
}
@end
