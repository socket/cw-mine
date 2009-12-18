//
//  CWMethod.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMethod.h"


@implementation CWMethod

- (id) init {
	self = [super init];
	if (self != nil) {
		_locker = [[NSLock alloc] init];
	}
	return self;
}

- (void) main {
	
}

- (void) lock {
	assert( _locker );
	[_locker lock];
}

- (void) unlock {
	assert( _locker );
	[_locker unlock];
}

- (void) dealloc {
	[_locker release];
	[super dealloc];
}

@end
