//
//  CWMatrix.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrix.h"

@implementation CWMatrix
@synthesize data = _data;

+ (id) matrixWithRows:(int)rows andColumns:(int)columns {
	return [[[CWMatrix alloc] initWithRows:rows andColumns:columns] autorelease];
}

- (id) initWithRows:(int)rows andColumns:(int)columns {
	if ( self = [super init] ) {
		self.data = [NSMutableArray arrayWithCapacity:rows];
		while( rows-- ) {
			NSMutableArray* colArray = [NSMutableArray arrayWithCapacity:columns];
			for ( int curCol = 0; curCol < columns; ++curCol ) {
				[colArray addObject:[NSNumber numberWithFloat:0.0]];
			}
			[_data addObject:colArray];
		}
	}
	
	return self;
}

- (id) copy {
	CWMatrix* newMatrix = [[CWMatrix alloc] initWithRows:self.rows andColumns:self.columns];
	assert(newMatrix);
	
	// FIXME
	
	return newMatrix;
}

#pragma mark Accessors
- (void) setValue:(double)value row:(int)row column:(int)column {
	assert( row < [_data count] );
	assert( column < [[_data objectAtIndex:row] count] );
	
	if ( column >= [[_data objectAtIndex:row] count] || row >= [_data count] ) {
		NSLog(@"SET Matrix value out of bounds %d, %d", row, column);
		return;
	}
	
	[[_data objectAtIndex:row] replaceObjectAtIndex:column withObject:[NSNumber numberWithDouble:value]];
}

- (double) valueForRow:(int)row column:(int)column {	
	if ( column >= self.columns || row >= self.rows ) {
		NSLog(@"GET Matrix value out of bounds %d, %d", row, column);
		return NAN;
	}

	return [[[_data objectAtIndex:row] objectAtIndex:column] doubleValue];
}

#pragma mark Base Matrix Operations
- (CWMatrix*) addMatrix:(CWMatrix*)matrix {
	if ( matrix.rows != self.rows || matrix.columns != self.columns ) {
		return nil;
	}
	
	CWMatrix* newMatrix = [self copy];
	for( int i=0; i < [newMatrix.data count]; ++i ) {
		NSMutableArray* rowArray = [newMatrix.data objectAtIndex:i];
		NSMutableArray* rowArray2 = [matrix.data objectAtIndex:i];
		
		assert( rowArray );
		for ( int j=0; j < [rowArray count]; ++j ) {
			[rowArray replaceObjectAtIndex:j withObject: [NSNumber numberWithDouble:([ [rowArray objectAtIndex:j] doubleValue ] + [[rowArray2 objectAtIndex:j] doubleValue]) ] ];
		}
	}
	
	return [newMatrix autorelease];
}

- (CWMatrix*) substractMatrix:(CWMatrix*)matrix {
	// FIXME: not a fast method but code is compact
	CWMatrix* subMatrix = [matrix multiplyByScalar:[NSNumber numberWithDouble:(-1)]];
	return [self addMatrix:subMatrix];
}

- (CWMatrix*) multiplyByScalar:(NSNumber*)scalar {
	CWMatrix* newMatrix = [self copy];
	for( int i=0; i < [newMatrix.data count]; ++i ) {
		NSMutableArray* rowArray = [newMatrix.data objectAtIndex:i];
		assert( rowArray );
		for ( int j=0; j < [rowArray count]; ++j ) {
			[rowArray replaceObjectAtIndex:j withObject: [NSNumber numberWithDouble:([ [rowArray objectAtIndex:j] doubleValue ] * [scalar doubleValue]) ] ];
		}
	}
	return [newMatrix autorelease];
}

#pragma mark Properties
- (NSUInteger) rows {
	return [_data count];
}

- (NSUInteger) columns {
	return [_data count] ? [[_data objectAtIndex:0] count] : 0;
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
	self.data = nil;
	
	[super dealloc];
}

#pragma mark debug
- (void) debugTrace {
	for( int i=0; i < self.rows; ++i ) {
		NSMutableString* rowData = [NSMutableString string];
		for ( int j=0; j < self.columns; ++j ) {
			[rowData appendFormat:@"%0.3f\t", [self valueForRow:i column:j]];
		}
		NSLog(@"%@", rowData);
	}
}

@end
