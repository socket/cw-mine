//
//  CWGraphPlotDataSource.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/20/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWGraphPlotDataSource.h"

@interface CWGraphPlotDataSource ( )

+ (NSString*) keyForArgument:(double)arg;

@property (nonatomic, retain)	NSMutableDictionary*	outputValues;
@property (nonatomic, retain)	NSMutableDictionary*	inputValues;

@end

@implementation CWGraphPlotDataSource

@synthesize outputValues = _outputValues, inputValues = _inputValues;
@synthesize outputKey = _outputKey;
@synthesize enabled = _enabled;
@synthesize resource = _resource;

#pragma mark -
+ (NSString*) keyForArgument:(double)arg {
	return [NSString stringWithFormat:@"%g", arg];
}

+ (id) dataSourceWithResourceClass:	(Class)aClass inputValues:(NSDictionary*)inputs outputKey:(NSString*)aKey {
	id dataSource = [[[self class] alloc] initWithResourceClass:aClass inputValues:inputs outputKey:aKey];
	return [dataSource autorelease];
}

#pragma mark -

- (id) initWithResourceClass:(Class)aClass inputValues:(NSDictionary*)inputs outputKey:(NSString*)aKey {
	if ( self = [super init] ) {
		_resource = aClass;
		self.inputValues = [NSMutableDictionary dictionaryWithDictionary:inputs];
		self.outputValues = [NSMutableDictionary dictionary];
		self.outputKey =  aKey;
	}
	return self;
}

#pragma mark -
#pragma mark graph delegate
- (double) graphicPlotView:(CWGraphPlotView*)plotView valueForArgument:(double)arg {
	if ( [self canProvideDataForArgument:arg] ) {
		return [[_outputValues valueForKey:[CWGraphPlotDataSource keyForArgument:arg]] doubleValue];
	}
	else {
		return 0.0;
	}

}

- (void)prepareDataInRangeBegin:(double)argBegin rangeEnd:(double)argEnd delegate:(id<CWOperationDelegate>)delegate {
	
}

- (BOOL) canProvideDataForArgument:(double)arg {
	return ( [_outputValues valueForKey:[CWGraphPlotDataSource keyForArgument:arg] ]!= nil );
}

#pragma mark -
#pragma mark operation delegate

- (void) operationSucceeded:(CWMethodOperation *)operation {
	
}

- (void) operationFailed:(CWMethodOperation *)operation {
	
}

#pragma mark -
- (void) dealloc {
	self.outputKey = nil;
	self.inputValues = nil;
	self.outputValues = nil;
	
	[super dealloc];
}

@end
