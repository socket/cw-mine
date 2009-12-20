//
//  NSArray+ComboDataSource.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/21/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSArray ( ComboDataSource )<NSComboBoxDataSource>

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox;
- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index;

@end
