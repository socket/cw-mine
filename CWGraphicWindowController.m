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
#import "CWParabolaOperation.h"

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

- (void)awakeFromNib {
	[_graphView setDelegate:self];
}

- (void) windowDidLoad {
	// Test code
	/*CWGraphPlotDataSource* ds = [[CWGraphPlotDataSource alloc] initWithResourceClass:[CWMatrixLUDecOperation class] inputValues:[NSDictionary dictionary] outputKey:kMethodElapsed];
	ds.inputKey = kMatrixRank;
	ds.plotColor = [NSColor redColor];
	[_graphView.dataSources addObject:ds];*/
	
	CWGraphPlotDataSource* ds = [[CWGraphPlotDataSource alloc] initWithResourceClass:[CWParabolaOperation class] inputValues:[NSDictionary dictionary] outputKey:@"y"];
	ds.inputKey = @"x";
	ds.plotColor = [NSColor redColor];
	ds.enabled = YES;
	[ds setRangeBegin:0.0];
	[ds setRangeEnd:100.0];
	[ds setRangeStep:1.0];
	[_graphView.dataSources addObject:ds];
	
	[_graphListTableView reloadData];
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
	else {
		return [dataSource valueForKeyPath:key];
	}

	return nil;
}

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	if ( [[tableColumn identifier] isEqualToString:@"color"] ) {
		
	}
}
#pragma mark -
#pragma mark actions
- (CWGraphPlotViewAxis*) graphicPlotView:(CWGraphPlotView*)view axisWithType:(CWGraphPlotAxisType)aType {
	return [CWGraphPlotViewAxis axisWithTitle:@"axis" minValue:0 maxValue:1000];
}

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
	else if ( [_segmentedControl selectedSegment] == 3 ) {
		[_graphView reloadData];
		[_graphListTableView reloadData];
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
