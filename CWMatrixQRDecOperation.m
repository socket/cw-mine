//
//  CWMatrixQRDecOperation.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/23/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixQRDecOperation.h"


@implementation CWMatrixQRDecOperation

- (BOOL) process {
	// just make it two times slower than LU
	[super process];
	[super process];
	
	return YES;
}

+ (NSString*) description {
	return @"QR-decomposition";
}

@end
