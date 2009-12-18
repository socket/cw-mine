//
//  CWMethod.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CWMethod : NSOperation {
	@private
	NSLock*	_locker;
}

- (void) main;
- (void) lock;
- (void) unlock;

@end
