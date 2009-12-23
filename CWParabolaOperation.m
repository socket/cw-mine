//
//  CWParabolaOperation.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/23/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWParabolaOperation.h"


@implementation CWParabolaOperation<CWMethodOperation>

- (BOOL) process {
	double result = [[_inputs valueForKey:@"x"] doubleValue];
	result *= result;
	
	[self.outputs setValue:result forKey:@"y"];	
	
	return YES;
}

+ (NSString*) description {
	return @"Parabola";
}

+ (NSArray*) inputKeys {
	return [NSArray arrayByAddingArray:[super inputKeys] andArray:[NSArray arrayWithObjects:@"x", nil]];
}

+ (NSArray*) outputKeys {
	return [NSArray arrayByAddingArray:[super outputKeys] andArray:[NSArray arrayWithObjects:
																	@"y",nil]];
}

@end
