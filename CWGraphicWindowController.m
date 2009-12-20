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
@synthesize segmentedControl = _segmentedControl;

- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		[self populateMethodClasses];
	}
	return self;
}

- (void) dealloc {
	self.graphListTableView = nil;
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
		//[self showAddMethodPane:sender];
	}
	else if ( [_segmentedControl selectedSegment] == 1 ) {
		//[self removeMethod:sender];
	}
	else if ( [_segmentedControl selectedSegment] == 2 ) {
		//[self showSettings:sender];
	}
}

- (IBAction) showAddMethodPane:(id)sender {

	//[_methodAddPane setFrameOrigin:<#(NSPoint)newOrigin#>
	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration:1.0f]; // However long you want the slide to take
	
	
//	[[_methodAddPane animator] setFrame:secondViewOnScreenFrame];
	
	[NSAnimationContext endGrouping];
}

@end
