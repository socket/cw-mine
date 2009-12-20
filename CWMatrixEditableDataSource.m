//
//  CWMatrixEditableDataSource.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/9/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMatrixEditableDataSource.h"

@implementation CWMatrixEditableDataSource

+ (id) dataSourceWithMatrix:(CWMatrix*)matrix {
	return [[[CWMatrixEditableDataSource alloc] initWithMatrix:matrix] autorelease];
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	int column = [[tableColumn identifier] intValue];
	NSNumber* value = [NSNumber numberWithDouble:[object doubleValue]];
	
	[self.matrix setValue:[value doubleValue] row:row column:column];
}

@end
