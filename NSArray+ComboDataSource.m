//
//  NSArray+ComboDataSource.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/21/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "NSArray+ComboDataSource.h"


@implementation NSArray ( ComboDataSource )

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
	return [self count];
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index {
	return [self objectAtIndex:index];
}

@end
