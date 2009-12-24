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

+ (id) matrixWithRows:(int)rows columns:(int)columns {
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
	
	memcpy(newMatrix.data, _data, _rows*_columns*sizeof(double));
	
	return newMatrix;
}

#pragma mark Accessors
- (void) setValue:(double)value row:(int)row column:(int)column {
	if ( column >= _columns || row >= _rows ) {
		NSLog(@"SET Matrix value out of bounds %d, %d", row, column);
		return;
	}
	
	_data[ row*_columns + column ] = value;
}

- (double) valueForRow:(int)row column:(int)column {	
	if ( column >= self.columns || row >= self.rows ) {
		NSLog(@"GET Matrix value out of bounds %d, %d", row, column);
		return NAN;
	}

	return _data[ row*_columns + column ];
}

#pragma mark Base Matrix Operations
- (CWMatrix*) addMatrix:(CWMatrix*)matrix {
	if ( matrix.rows != self.rows || matrix.columns != self.columns ) {
		return nil;
	}
	
	CWMatrix* newMatrix = [self copy];
	for (int i=0; i<_rows; ++i)
		for (int j=0; j<_columns; ++j) 
			newMatrix.data[i*_columns + j] += matrix.data[i*_columns+j];
	
	return [newMatrix autorelease];
}

- (CWMatrix*) substractMatrix:(CWMatrix*)matrix {
	if ( matrix.rows != self.rows || matrix.columns != self.columns ) {
		return nil;
	}
	
	CWMatrix* newMatrix = [self copy];
	for (int i=0; i<_rows; ++i)
		for (int j=0; j<_columns; ++j) 
			newMatrix.data[i*_columns + j] -= matrix.data[i*_columns+j];
	
	return [newMatrix autorelease];
}

- (CWMatrix*) multiplyByScalar:(double)scalar {
	CWMatrix* newMatrix = [self copy];
	
	for (int i=0; i<_rows; ++i)
		for (int j=0; j<_columns; ++j) 
			newMatrix.data[i*_columns + j] *= scalar;
	
	return [newMatrix autorelease];
}


- (CWMatrix*)multiplyByMatrix:(CWMatrix*)matrix{
	if(_columns != matrix.rows){
		return nil;
	}
	
	NSUInteger mColumns = matrix.columns;
	CWMatrix* matris = [CWMatrix matrixWithRows:_rows columns:mColumns];

	for(NSUInteger i = 0; i < _rows; i++) {
		for(NSUInteger j = 0; j < mColumns; j++) {
			double sum = 0.0;
			for(NSUInteger k = 0; k < _columns; k++) {
				sum += [self valueForRow:i column:k] * [matrix valueForRow:k column:j];
			}
			
			[matris setValue:sum row:i column:j];
		}
	}
	return matris;
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

- (double*) copyAsArray {
	double* array = calloc(columns*rows, sizeof(double));
	memcpy(array, _data, columns*rows * sizeof(double) );
	return array;
}

- (void) dealloc {
	free(_data);
	
	[super dealloc];
}

#pragma mark debug

- (NSString*)description{
	NSMutableString* str = [NSMutableString new];
	[str appendString:@"{"];
	for(NSUInteger i = 0; i < _rows; i++){
		[str appendString:@"{"];
		for(NSUInteger j = 0; j < _columns; j++){
			[str appendFormat:@"%g", [self valueForRow:i column:j]];
			if(j+1 != _columns)
				[str appendString:@","];
		}
		[str appendString:@"}"];
		if(i+1 != _rows)
			[str appendString:@",\n"];
	}
	[str appendString:@"}"];
	[str autorelease];
	return str;
}

@end
