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
#import "CWAddPlotWindowController.h"
#import "CWMatrixDataSource.h"
#import "CWGraphPlotDataSource.h"

@interface CWGraphicWindowController ( )
- (void) populateMethodClasses;
- (void)addMethod:(NSNotification*)notification;

@end;

@implementation CWGraphicWindowController

@synthesize graphListTableView = _graphListTableView, graphView = _graphView;;
@synthesize segmentedControl = _segmentedControl;

- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		[self populateMethodClasses];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addMethod:) name:kNotificationAddPlotMethod object:nil];
		
	}
	return self;
}

- (void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	self.graphListTableView = nil;
	self.graphView = nil;
	self.segmentedControl = nil;
	
	[super dealloc];
}

- (void) populateMethodClasses {
	//_methodsDataSource = [[NSArray arrayWithObjects:[CWMatrixLUDecOperation class], [CWMethodOperation class], nil] retain];
}

#pragma mark -
#pragma mark notifications
- (void)addMethod:(NSNotification*)notification {
	CWGraphPlotDataSource* dataSource = [notification object];

	if ( dataSource ) {
		[_graphView.dataSources addObject:dataSource];
		[_graphView reloadData];
		[_graphListTableView reloadData];
	}
}

#pragma mark -
#pragma mark table view datasource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	return [_graphView.dataSources count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	NSString* key = [tableColumn identifier];
	CWGraphPlotDataSource* dataSource = [_graphView.dataSources objectAtIndex:row];
	
	if ([key isEqualToString:@"id"]) {
		return [NSNumber numberWithInt:(row+1)];
	} 
	else if ([key isEqualToString:@"name"]) {
		return [dataSource methodName];
	}
	else if ([key isEqualToString:@"color"]) {
		return [dataSource plotColor];
	}

	return nil;
}


#pragma mark -
#pragma mark actions


- (IBAction) segmentedSelector:(id)sender {
	if ( [_segmentedControl selectedSegment] == 0 ) {
		CWAddPlotWindowController* controller = [[CWAddPlotWindowController controller] retain];  // FIXME: MEMORY LEAK
		[controller showWindow:self];
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
