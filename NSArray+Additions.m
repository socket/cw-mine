//
//  NSArrayAdditions.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/21/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "NSArray+Additions.h"


@implementation NSArray (Additions)

+ (NSArray*) arrayByAddingArray:(NSArray*)array1 andArray:(NSArray*)array2 {
	NSMutableArray* array = [NSMutableArray arrayWithArray:array1];
	[array addObjectsFromArray:array2];
	return array;
}

@end
