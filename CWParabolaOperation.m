//
//  CWParabolaOperation.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/23/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWParabolaOperation.h"


@implementation CWParabolaOperation

- (BOOL) process { // a bit of magic
	double result = [[_inputs valueForKey:@"x"] doubleValue];
	result = pow(1.0/10.0*result, 2);
	
	[self.outputs setValue:[NSNumber numberWithDouble:result] forKey:@"y"];	
	
	return YES;
}

+ (NSString*) description {
	return @"QR Decomposition";
}

+ (NSArray*) inputKeys {
	return [NSArray arrayByAddingArray:[super inputKeys] andArray:[NSArray arrayWithObjects:@"x", nil]];
}

+ (NSArray*) outputKeys {
	return [NSArray arrayByAddingArray:[super outputKeys] andArray:[NSArray arrayWithObjects:
																	@"y",nil]];
}


+ (BOOL) allowsSynchronousExecution {
	return NO;
}

@end
