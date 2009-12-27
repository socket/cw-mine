//
//  CWMatrixTableView.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixTableView.h"

#import "CWMatrixEditableDataSource.h"

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
		_matrixDataSource = [[CWMatrixEditableDataSource alloc] initWithMatrix:matrix];
		self.dataSource = _matrixDataSource;
		self.delegate = self;
		
		for (int i=0; i<MIN(500, matrix.columns); ++i) {
			NSTableColumn* column = [[[NSTableColumn alloc]	initWithIdentifier:[NSNumber numberWithInt:i]] autorelease];
			NSTextFieldCell* cell = [[[NSTextFieldCell alloc] init] autorelease];
			[cell setEditable:YES];
			[column setDataCell:cell];
			[column setHeaderCell:[[[NSTableHeaderCell alloc] initTextCell:[NSString stringWithFormat:@"%d", i]] autorelease]];
			[column setEditable:YES];
			
			[self addTableColumn:column];
		}
	}
	
	[self setColumnAutoresizingStyle:NSTableViewUniformColumnAutoresizingStyle];
	[self reloadData];
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return YES;
}

- (void) dealloc {
	[_matrixDataSource release];
	[super dealloc];
}

@end
