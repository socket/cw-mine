//
//  CWMethod.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMethodOperation.h"

@interface CWMethodOperation ( )


@property (nonatomic, retain) NSMutableDictionary* outputs;
@property (nonatomic, retain) NSMutableDictionary* inputs;

@end

@implementation CWMethodOperation
@synthesize delegate	= _delegate;
@synthesize error		= _error;
@synthesize outputs		= _outputs;
@synthesize inputs		= _inputs;

- (id) init {
	self = [super init];
	if (self != nil) {
		_locker = [[NSLock alloc] init];
		self.outputs =	[NSMutableDictionary dictionary];
		self.inputs	 =	[NSMutableDictionary dictionary];
		
	}
	return self;
}

- (void) main {
	// benchmarking code
	NSDate* beginDate = [NSDate date];
	[self.outputs setValue:beginDate forKey:kMethodDateBegin];
	
	BOOL result = [self process];
	
	NSDate* endDate = [NSDate date];
	[self.outputs setValue:endDate forKey:kMethodDateEnd];
	[self.outputs setValue:[NSNumber numberWithDouble: [beginDate timeIntervalSinceNow] ] forKey:kMethodElapsed];
	
	result ? [self succceed] : [self fail];
}

- (BOOL) process {
	return YES;
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
	[_outputs release];
	[_inputs release];
	
	[super dealloc];
}

- (void) succceed {
	//[self.delegate performSelectorOnMainThread:@selector(operationSucceeded:) withObject:self waitUntilDone:YES];
	[self.delegate operationSucceeded:self];
}

- (void) fail {
	[self.delegate operationFailed:self];
}

+ (NSString*) description {
	return @"Generic method operation";
}

+ (NSArray*) outputKeys {
	return [NSArray arrayWithObjects:kMethodElapsed, kMethodDateBegin, kMethodDateEnd];
}

@end
