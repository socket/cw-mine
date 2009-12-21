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
	
	NSMutableDictionary*		_inputValues;
	NSMutableDictionary*		_outputValues;  // contains dictionary->outputKey
	NSString*					_outputKey;
	Class						_resource;
	BOOL						_enabled;
	
}

+ (id) dataSourceWithResourceClass:	(Class)aClass inputValues:(NSDictionary*)inputs outputKey:(NSString*)aKey;
- (id) initWithResourceClass:		(Class)aClass inputValues:(NSDictionary*)inputs outputKey:(NSString*)aKey;

- (BOOL) canProvideDataForArgument:(double)arg;
- (void) prepareDataInRangeBegin:(double)argBegin rangeEnd:(double)argEnd delegate:(id<CWOperationDelegate>)delegate;

@property (nonatomic, copy)		NSString*				outputKey;
@property (nonatomic, readonly) Class					resource;
@property (nonatomic, assign)   BOOL					enabled;

@end
