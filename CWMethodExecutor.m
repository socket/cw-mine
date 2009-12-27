//
//  CWMethodExecutor.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/20/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMethodExecutor.h"


@implementation CWMethodExecutor

+ (CWMethodExecutor*) sharedInstance {
	static CWMethodExecutor* instance;
	if ( ! instance ) {
		instance = [[[self class] alloc] init];
	}
	return instance;
}

- (id) init {
	self = [super init];
	if (self != nil) {
		_queue = [[NSOperationQueue alloc] init];
		//[_queue setMaxConcurrentOperationCount:1];
	}
	return self;
}

- (void)addOperation:(CWMethodOperation*)operation {
	[_queue addOperation:operation];
}

-(void) dealloc {
	[_queue release];
	[super dealloc];
}

@end
