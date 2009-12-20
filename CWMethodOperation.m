//
//  CWMethod.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMethodOperation.h"


@implementation CWMethodOperation
@synthesize delegate = _delegate;
@synthesize error = _error;
@synthesize output = _output;

- (id) init {
	self = [super init];
	if (self != nil) {
		_locker = [[NSLock alloc] init];
		self.output = [NSMutableDictionary dictionary];
		
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
	[_error release];
	[_output release];
	
	[super dealloc];
}

- (void) succceed {
	//[self.delegate performSelectorOnMainThread:@selector(operationSucceeded:) withObject:self waitUntilDone:YES];
	[self.delegate operationSucceeded:self];
}

- (void) fail {
	[self.delegate operationFailed:self];
}

@end
