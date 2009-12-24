//
//  CWMatrixQRDecOperation.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/23/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixQRDecOperation.h"
#import "CWQRDecomposition.h"
#import "CWMatrixInitializer.h"

@implementation CWMatrixQRDecOperation
- (id) initWithMatrix:(CWMatrix*)matrix {
	if ( self = [self init] ) {
		[_inputs setValue:matrix forKey:kSourceMatrix];
	}
	return self;
}

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
	
	CWQRDecomposition* dc = [[CWQRDecomposition alloc] initWithMatrix:matrix];
	[dc decompose];
	
	[self.outputs setValue:[dc matrixQ] forKey:kQMatrix];
	[self.outputs setValue:[dc matrixR] forKey:kRMatrix];
	[self.outputs setValue:[dc matrixH] forKey:kHMatrix];	
	
	[dc release];
	
	return YES;
}


-(CWMatrix*) srcMatrix {
	return [_inputs valueForKey:kSourceMatrix];
}


+ (NSString*) description {
	return @"QR-decomposition";
}

+ (NSArray*) outputKeys {
	return [NSArray arrayByAddingArray:[super outputKeys] andArray:[NSArray arrayWithObjects:
																	kQMatrix,
																	kRMatrix, kHMatrix, nil]];
}

+ (NSArray*) inputKeys {
	return [NSArray arrayByAddingArray:[super inputKeys] andArray:[NSArray arrayWithObjects:
																   kSourceMatrix,
																   kMatrixRank, nil]];
}


+ (BOOL) allowsSynchronousExecution {
	return NO;
}

@end
