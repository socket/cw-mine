//
//  CWGraphPlotDataSource.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/20/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMethodOperation.h"
#import "CWGraphPlotView.h"


@interface CWGraphPlotDataSource : NSObject<CWOperationDelegate,
											CWGraphPlotViewDataSource> 
{
	@private
	NSLock*					_locker;
	
	NSMutableDictionary*		_inputValues;
	NSMutableDictionary*		_outputValues;  // contains dictionary->outputKey
	NSString*					_outputKey;		// used for drawing
	Class						_resource;
	BOOL						_enabled;

	NSString*					_inputKey;		// changeable input key (in some range)
	double						_rangeBegin;
	double						_rangeEnd;
	double						_rangeStep;

	int							_operationsTotal;
	int							_operationsDone;
	
	NSColor*					_plotColor;
	
	id<CWOperationDelegate>		_prepareDelegate;
}

+ (id) dataSourceWithResourceClass:	(Class)aClass inputValues:(NSDictionary*)inputs outputKey:(NSString*)aKey;
- (id) initWithResourceClass:		(Class)aClass inputValues:(NSDictionary*)inputs outputKey:(NSString*)aKey;

- (BOOL) canProvideDataForArgument:(double)arg;
- (void) prepareDataInRangeBegin:(double)argBegin rangeEnd:(double)argEnd delegate:(id<CWOperationDelegate>)delegate;

- (double) progressPercent;

- (NSString*) methodName;

@property (nonatomic, copy)		NSString*				outputKey;
@property (nonatomic, copy)		NSString*				inputKey;

@property (nonatomic, readonly) Class					resource;
@property (nonatomic, assign)   BOOL					enabled;

@property (nonatomic, copy)		NSColor*				plotColor;

@property (nonatomic, assign) double rangeBegin;
@property (nonatomic, assign) double rangeEnd;
@property (nonatomic, assign) double rangeStep;

@end
