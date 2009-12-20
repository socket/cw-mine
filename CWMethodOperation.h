//
//  CWMethod.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CWMethodOperation;

@protocol CWOperationDelegate<NSObject>
@required

-(void)operationSucceeded:(CWMethodOperation*)operation;
-(void)operationFailed:(CWMethodOperation*)operation;

@end

@interface CWMethodOperation : NSOperation {
	@private
	NSLock*		_locker;
	
	@protected
	NSError*	_error;
	id<CWOperationDelegate> _delegate;
	
	NSMutableDictionary*	_output;
}

@property (nonatomic, assign) id<CWOperationDelegate> delegate;
@property (nonatomic, retain) NSError*	error;
@property (nonatomic, retain) NSMutableDictionary* output;

- (void) main;
- (void) lock;
- (void) unlock;

- (void) succceed;
- (void) fail;

@end