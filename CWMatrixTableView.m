//
//  CWMatrixTableView.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixTableView.h"


@implementation CWMatrixTableView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (CWMatrix*) matrix {
	return _matrixDataSource.matrix;
}

- (void) setMatrix:(CWMatrix *)matrix {
	NSArray* arrColumns = [NSArray arrayWithArray:self.tableColumns];
	for(NSTableColumn* column in arrColumns) {
		[self removeTableColumn:column];
	}

	self.allowsColumnReordering = NO;
	
	if ( matrix ) {
		_matrixDataSource = [[CWMatrixDataSource alloc] initWithMatrix:matrix];
		self.dataSource = _matrixDataSource;
		
		for (int i=0; i<matrix.rows; ++i) {
			NSTableColumn* column = [[[NSTableColumn alloc]	initWithIdentifier:[NSNumber numberWithInt:i]] autorelease];
			[column setDataCell:[[[NSCell alloc] initTextCell:[NSString stringWithFormat:@"%d", i]] autorelease]];
			[column setHeaderCell:[[[NSTableHeaderCell alloc] initTextCell:[NSString stringWithFormat:@"%d", i]] autorelease]];
			[column setEditable:YES];
			
			[self addTableColumn:column];
		}
	}
	
	[self setColumnAutoresizingStyle:NSTableViewUniformColumnAutoresizingStyle];
	[self reloadData];
}

- (void) dealloc {
	[_matrixDataSource release];
	[super dealloc];
}

@end
