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
#import "CWGraphPlotDataSource.h"

NSString* const kNotificationAddPlotMethod		= @"CW.Notification.Add.Plot.Method";

@implementation CWAddPlotWindowController

@synthesize methodAddButton = _methodAddButton;
@synthesize methodNameComboBox = _methodNameComboBox, methodKeyComboBox = _methodKeyComboBox;
@synthesize methodColor = _methodColor, methodPrecision = _methodPrecision;
@synthesize methodInputKeyComboBox = _methodInputKeyComboBox;

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
	[_methodKeyComboBox setDelegate:self];
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
	// update available keys
	Class selClass = [[CWMethodDataSource useableMethodArray] objectAtIndex:[_methodNameComboBox indexOfSelectedItem]];
	[_methodKeyComboBox setDataSource:[[selClass outputKeys] retain] ];  // FIXME: memory leak
	[_methodKeyComboBox reloadData];
	
	[_methodInputKeyComboBox setDataSource:[[selClass inputKeys] retain] ];  // FIXME: memory leak
	[_methodInputKeyComboBox reloadData];
		
	BOOL enabled = ([_methodKeyComboBox indexOfSelectedItem] >= 0) && ([_methodNameComboBox indexOfSelectedItem] >= 0);
	[_methodAddButton setEnabled:enabled];
}

- (IBAction)performAdd:(id)sender {
	Class selClass = [[CWMethodDataSource useableMethodArray] objectAtIndex:[_methodNameComboBox indexOfSelectedItem]];
	NSArray* keys = [[selClass outputKeys] retain];
	NSArray* inputKeys = [[selClass inputKeys] retain];
	
	NSString* selKey = [keys objectAtIndex: [_methodKeyComboBox indexOfSelectedItem]];
	[keys release];
	NSString* selInputKey = [inputKeys objectAtIndex: [_methodInputKeyComboBox indexOfSelectedItem]];
	[inputKeys release];
	
	CWGraphPlotDataSource* dataSource = [[[CWGraphPlotDataSource alloc] initWithResourceClass:selClass inputValues:[NSDictionary dictionary] outputKey:selKey] autorelease]; // FIXME: check if object'll be alive
	
	dataSource.inputKey = selInputKey;
	dataSource.plotColor = [_methodColor color];
	
	NSDictionary* userInfo = [NSDictionary dictionary];	
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationAddPlotMethod object:dataSource userInfo:userInfo];
	[self.window close];
}


-(void) dealloc {
	self.methodAddButton = nil;
	self.methodNameComboBox = nil;
	self.methodColor = nil;
	self.methodKeyComboBox = nil;
	self.methodPrecision = nil;
	self.methodInputKeyComboBox = nil;
	
	[super dealloc];
}
@end
