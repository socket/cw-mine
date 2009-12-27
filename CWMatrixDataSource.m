//
//  CWMatrixDataSource.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixDataSource.h"


@implementation CWMatrixDataSource
@synthesize matrix = _matrix;

+ (id) dataSourceWithMatrix:(CWMatrix*)matrix {
	return [[[CWMatrixDataSource alloc] initWithMatrix:matrix] autorelease];
}

- (id) initWithMatrix:(CWMatrix*)matrix {
	if ( self = [super init] ) {
		_matrix = [matrix retain];
	}
	return self;
}

- (void) dealloc {
	[_matrix release];
	[super dealloc];
}

#pragma mark Data Source
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	return MIN(500, [_matrix rows]);
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	int col = [[tableColumn identifier] intValue];
	return [NSString stringWithFormat:@"%0.3f", [_matrix valueForRow:row column:col]];
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	
}

@end
