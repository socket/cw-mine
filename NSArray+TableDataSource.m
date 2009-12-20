//
//  CWMethodListDataSource.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/20/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "NSArray+TableDataSource.h"


@implementation NSArray ( TableDataSource )

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	return [self count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return [[self objectAtIndex:row] description];
}

@end
