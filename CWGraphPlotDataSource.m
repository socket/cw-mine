//
//  CWGraphPlotDataSource.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/20/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWGraphPlotDataSource.h"
#import "CWMethodExecutor.h"

@interface CWGraphPlotDataSource ( )

+ (NSString*) keyForArgument:(double)arg;

- (CWMethodOperation *) operationForArgument: (double) fval;


@property (nonatomic, retain)	NSMutableDictionary*	outputValues;
@property (nonatomic, retain)	NSMutableDictionary*	inputValues;

@end

@implementation CWGraphPlotDataSource

@synthesize outputValues = _outputValues, inputValues = _inputValues;
@synthesize outputKey = _outputKey;
@synthesize enabled = _enabled;
@synthesize resource = _resource;
@synthesize inputKey = _inputKey;
@synthesize plotColor = _plotColor;
@synthesize methodName;

@synthesize rangeBegin = _rangeBegin, rangeEnd = _rangeEnd, rangeStep = _rangeStep;

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
		
		_rangeStep = 1.0;
		_locker = [[NSLock alloc] init];
	}
	return self;
}

#pragma mark -
#pragma mark graph delegate
- (double) graphicPlotView:(CWGraphPlotView*)plotView valueForArgument:(double)arg {
	id value = [_outputValues valueForKey:[CWGraphPlotDataSource keyForArgument:arg]];
	if ( value ) {
		return [[value valueForKey:_outputKey] doubleValue];
	}
	else {
		// make it happen SYNCHRONOUSLY
		if ( [_resource allowsSynchronousExecution] ) {
			CWMethodOperation* op = [self operationForArgument:arg];
			[op main];
			
			return [[[op outputs] valueForKey:_outputKey] doubleValue];			
		}
		else {
			return 0.0;
		}
	}
}

- (CWMethodOperation *) operationForArgument: (double) fval  {
	CWMethodOperation* calcOperation = [[_resource alloc] init];
	[calcOperation.inputs addEntriesFromDictionary:_inputValues];
	[calcOperation.inputs setValue:[NSNumber numberWithDouble:fval] forKey:_inputKey];

	return [calcOperation autorelease];
}

- (void)prepareDataInRangeBegin:(double)argBegin rangeEnd:(double)argEnd delegate:(id<CWOperationDelegate>)delegate {
	_rangeBegin = argBegin;
	_rangeEnd = argEnd;

	if ( _rangeEnd < _rangeBegin ) {
		_rangeEnd = argBegin;
		_rangeBegin = argEnd;
	}
	
	if ( _rangeStep == 0 ) {
		_rangeStep = (_rangeEnd - _rangeBegin) / 1000.0f;
	}
	
	_prepareDelegate = delegate; // we'll call him when everything's done
	
	_operationsDone = 0;
	_operationsTotal = 0;
	
	[_outputValues removeAllObjects];
	
	CWMethodOperation* generalOperation = [[CWMethodOperation alloc] init];
	for (double fval =_rangeBegin; fval <= _rangeEnd; fval += _rangeStep) {
		_operationsTotal++;
		
		CWMethodOperation *calcOperation = [self operationForArgument: fval];

		int k = [calcOperation retainCount];
		calcOperation.delegate = self;
		//[generalOperation addDependency:calcOperation];
		[[CWMethodExecutor sharedInstance] addOperation:calcOperation];
	}
	
	generalOperation.delegate = self;
	//[[CWMethodExecutor sharedInstance] addOperation:generalOperation];
	[generalOperation release];
}

- (int) progressPercent {
	if ( _operationsTotal == 0 )
		return 0;
	
	return (_operationsDone * 1.0) / _operationsTotal  * 100;
}

- (BOOL) canProvideDataForArgument:(double)arg {
	if ( [_resource allowsSynchronousExecution] )
		return YES;
	
	return ( [_outputValues valueForKey:[CWGraphPlotDataSource keyForArgument:arg] ]!= nil );
}

#pragma mark -
#pragma mark operation delegate

- (void) operationSucceeded:(CWMethodOperation *)operation {
	if ( [operation isKindOfClass:_resource] ) {
		[_locker lock];
		@try {
			NSString* key = [[self class] keyForArgument:[[operation.inputs valueForKey:_inputKey] doubleValue]];
			[_outputValues setValue:operation.outputs forKey:key];
			_operationsDone++;
		}
		@finally {
			[_locker unlock];
		}
	}
	else {
		[_prepareDelegate operationSucceeded:operation];
	}

}

- (void) operationFailed:(CWMethodOperation *)operation {
	
}

- (NSString*) methodName {
	return [_resource description];
}


#pragma mark -
- (void) dealloc {
	[_locker release];
	
	self.outputKey = nil;
	self.inputValues = nil;
	self.inputKey = nil;
	self.outputValues = nil;
	self.plotColor = nil;
	
	[super dealloc];
}

@end
