//
//  CWNewPlotWindowController.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/21/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWAddPlotWindowController.h"
#import "NSArray+ComboDataSource.h"
#import "CWMethodDataSource.h"

NSString* const kNotificationAddPlotMethod		= @"CW.Notification.Add.Plot.Method";

@implementation CWAddPlotWindowController

@synthesize methodAddButton = _methodAddButton;
@synthesize methodNameComboBox = _methodNameComboBox, methodKeyComboBox = _methodKeyComboBox;
@synthesize methodColor = _methodColor, methodPrecision = _methodPrecision;


+ controller {
	id controller = [[[self class] alloc] initWithWindowNibName:@"CWAddPlotWindowController"];
	return [controller autorelease];
}

#pragma mark -
- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		
	}
	return self;
}

- (void) awakeFromNib {
	[_methodNameComboBox setDataSource:[CWMethodDataSource useableMethodArray]];
	[_methodNameComboBox setDelegate:self];
	[_methodNameComboBox reloadData];
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
	// update available keys
	
}

- (IBAction)performAdd:(id)sender {
	[self.window close];
}


-(void) dealloc {
	self.methodAddButton = nil;
	self.methodNameComboBox = nil;
	self.methodColor = nil;
	self.methodKeyComboBox = nil;
	self.methodPrecision = nil;
	
	[super dealloc];
}
@end
