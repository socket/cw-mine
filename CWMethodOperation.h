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
	
	NSMutableDictionary*	_outputs;
	NSMutableDictionary*	_inputs;
	
}

@property (nonatomic, assign) id<CWOperationDelegate> delegate;
@property (nonatomic, retain) NSError*	error;

-(NSMutableDictionary*) outputs;
-(NSMutableDictionary*) inputs;

- (void) lock;
- (void) unlock;

- (BOOL) process;		// this should be overridden

- (void) succceed;
- (void) fail;
@end
