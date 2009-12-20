//
//  CWMethodExecutor.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/20/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMethodOperation.h"

@interface CWMethodExecutor : NSObject {

	@private
	NSOperationQueue* _queue;
}

+ (CWMethodExecutor*) sharedInstance;

- (id)init;
- (void)addOperation:(CWMethodOperation*)operation;

@end
