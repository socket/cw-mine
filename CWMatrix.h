//
//  CWMatrix.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CWMatrix : NSObject {
	@private
	double*		_data;
	
	NSUInteger	_rows;
	NSUInteger	_columns;
}

+ (id) matrixWithRows:(int)rows andColumns:(int)columns;
- (id) initWithRows:(int)rows andColumns:(int)columns;

- (CWMatrix*) addMatrix:(CWMatrix*)matrix;
- (CWMatrix*) substractMatrix:(CWMatrix*)matrix;
- (CWMatrix*) multiplyByScalar:(NSNumber*)scalar;

- (double) valueForRow:(int)row column:(int)column;
- (void) setValue:(double)value row:(int)row column:(int)column;

- (void) debugTrace;

//

@property (nonatomic, readonly) BOOL square;
@property (nonatomic, readonly) NSUInteger rows;
@property (nonatomic, readonly) NSUInteger columns;
@property (nonatomic, readonly) NSUInteger rank;

@end
