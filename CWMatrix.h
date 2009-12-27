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

+ (id) matrixWithRows:(int)rows columns:(int)columns;
- (id) initWithRows:(int)rows andColumns:(int)columns;
- (id) initWithData:(double*)data rows:(int)rows columns:(int)columns;

- (CWMatrix*) addMatrix:(CWMatrix*)matrix;
- (CWMatrix*) substractMatrix:(CWMatrix*)matrix;
- (CWMatrix*) multiplyByScalar:(double)scalar;
- (CWMatrix*) multiplyByMatrix:(CWMatrix*)matrix;

- (double) valueForRow:(int)row column:(int)column;
- (void) setValue:(double)value row:(int)row column:(int)column;

- (NSString*)description;

- (double*) copyAsArray;

// submatrices

- (CWMatrix*) submatrixWithRows:(NSArray*)rows initialColumn:(int)j0 finalColumn:(int)j1;
- (CWMatrix*) submatrixWithInitialRow:(int)i0 finalRow:(int)i1 initialColumn:(int)j0 finalColumn:(int)j1;


@property (nonatomic, readonly) BOOL square;
@property (nonatomic, readonly) NSUInteger rows;
@property (nonatomic, readonly) NSUInteger columns;
@property (nonatomic, readonly) NSUInteger rank;


@property (nonatomic, readonly) double* data;

@end
