//
//  CWMatrix.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrix.h"

@interface CWMatrix ()

@property (nonatomic, readonly) double* data;

@end

@implementation CWMatrix
@synthesize data = _data;

+ (id) matrixWithRows:(int)rows andColumns:(int)columns {
	return [[[CWMatrix alloc] initWithRows:rows andColumns:columns] autorelease];
}

- (id) initWithRows:(int)rows andColumns:(int)columns {
	if ( rows == 0 || columns == 0 ) {
		[self release];
		return nil;
	}
	
	if ( self = [super init] ) {
		_columns = columns;
		_rows = rows;
		
		_data = calloc(columns*rows, sizeof(double));
	}
	
	return self;
}

- (id) copy {
	CWMatrix* newMatrix = [[CWMatrix alloc] initWithRows:self.rows andColumns:self.columns];
	assert(newMatrix);
	
	memccpy(newMatrix.data, _data, _rows*_columns, sizeof(double));
	
	return newMatrix;
}

#pragma mark Accessors
- (void) setValue:(double)value row:(int)row column:(int)column {
	if ( column >= _columns || row >= _rows ) {
		NSLog(@"SET Matrix value out of bounds %d, %d", row, column);
		return;
	}
	
	_data[ column*_columns + row ] = value;
}

- (double) valueForRow:(int)row column:(int)column {	
	if ( column >= self.columns || row >= self.rows ) {
		NSLog(@"GET Matrix value out of bounds %d, %d", row, column);
		return NAN;
	}

	return _data[ column*_columns + row ];
}

#pragma mark Base Matrix Operations
- (CWMatrix*) addMatrix:(CWMatrix*)matrix {
	if ( matrix.rows != self.rows || matrix.columns != self.columns ) {
		return nil;
	}
	
	CWMatrix* newMatrix = [self copy];

	return [newMatrix autorelease];
}

- (CWMatrix*) substractMatrix:(CWMatrix*)matrix {
	// FIXME: not a fast method but code is compact
	CWMatrix* subMatrix = [matrix multiplyByScalar:[NSNumber numberWithDouble:(-1)]];
	return [self addMatrix:subMatrix];
}

- (CWMatrix*) multiplyByScalar:(NSNumber*)scalar {
	CWMatrix* newMatrix = [self copy];

	return [newMatrix autorelease];
}

#pragma mark Properties
- (NSUInteger) rows {
	return _rows;
}

- (NSUInteger) columns {
	return _columns;
}

- (NSUInteger ) rank {
	if ( !self.square )
		return 0;
	
	return self.rows;
}

- (BOOL) square {
	return (self.rows == self.columns);
}

- (void) dealloc {
	free(_data);
	
	[super dealloc];
}

#pragma mark debug
- (void) debugTrace {
	for( int i=0; i < self.rows; ++i ) {
		NSMutableString* rowData = [NSMutableString string];
		for ( int j=0; j < self.columns; ++j ) {

		}
		
		NSLog(@"%@", rowData);
	}
}

@end
