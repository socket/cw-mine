//
//  CWGraphicWindowController.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWGraphicWindowController.h"
#import "CWMatrixLUDecOperation.h"
#import "CWMethodOperation.h"
#import "NSArray+TableDataSource.h"

@interface CWGraphicWindowController ( )
- (void) populateMethodClasses;

@end;

@implementation CWGraphicWindowController

@synthesize graphListTableView = _graphListTableView, graphView = _graphView;;
@synthesize methodAddPane = _methodAddPane, methodNameComboBox = _methodNameComboBox, methodKeyComboBox = _methodKeyComboBox;
@synthesize methodColor = _methodColor, methodPrecision = _methodPrecision;
@synthesize segmentedControl = _segmentedControl;

- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		[self populateMethodClasses];
	}
	return self;
}

- (void) dealloc {
	self.graphListTableView = nil;
	self.methodAddPane = nil;
	self.methodNameComboBox = nil;
	self.methodColor = nil;
	self.methodKeyComboBox = nil;
	self.methodPrecision = nil;
	self.graphView = nil;
	self.segmentedControl = nil;
	
	[super dealloc];
}

- (void) populateMethodClasses {
	_methodsDataSource = [[NSArray arrayWithObjects:[CWMatrixLUDecOperation class], [CWMethodOperation class], nil] retain];
}

#pragma mark -
#pragma mark actions


- (IBAction) segmentedSelector:(id)sender {
	if ( [_segmentedControl selectedSegment] == 0 ) {
		[self showAddMethodPane:sender];
	}
	else if ( [_segmentedControl selectedSegment] == 1 ) {
		[self removeMethod:sender];
	}
	else if ( [_segmentedControl selectedSegment] == 2 ) {
		[self showSettings:sender];
	}
}

- (IBAction) addMethod:(id)sender {
	
}

- (IBAction) removeMethod:(id)sender {
	
}

- (IBAction) showSettings:(id)sender {
	
}

- (IBAction) hideSettings:(id)sender {
	
}

- (IBAction) showAddMethodPane:(id)sender {
	
}

- (IBAction) hideAddMethodPane:(id)sender {
	
}

@end
