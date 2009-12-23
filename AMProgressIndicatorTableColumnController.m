//
//  AMProgressIndicatorTableColumnController.m
//  IPICellTest
//
//  Created by Andreas on 23.01.07.
//  Copyright 2007 Andreas Mayer. All rights reserved.
//

#import "AMProgressIndicatorTableColumnController.h"


@interface AMProgressIndicatorTableColumnController (Private)
- (NSTimer *)heartbeatTimer;
- (void)setHeartbeatTimer:(NSTimer *)value;
- (void)animate:(NSTimer *)aTimer;
@end


@implementation AMProgressIndicatorTableColumnController

- (id)initWithTableColumn:(NSTableColumn *)column
{
	if (self = [super init]) {
		tableColumn = column;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:[[tableColumn tableView] window]];
	}
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[heartbeatTimer invalidate];
	[heartbeatTimer release];
	[super dealloc];
}

- (NSTimer *)heartbeatTimer
{
	return heartbeatTimer;
}

- (void)setHeartbeatTimer:(NSTimer *)value
{
	if (heartbeatTimer != value) {
		id old = heartbeatTimer;
		heartbeatTimer = [value retain];
		[old invalidate];
		[old release];
	}
}


- (void)windowWillClose:(NSNotification *)aNotification
{
	[heartbeatTimer invalidate];
	tableColumn = nil;
}

- (void)startAnimation
{
	if ([self heartbeatTimer] == nil) {
		[self setHeartbeatTimer:[NSTimer scheduledTimerWithTimeInterval:[(id)[tableColumn dataCell] animationDelay]  target:self selector:@selector(animate:) userInfo:NULL repeats:YES]];
		[[NSRunLoop currentRunLoop] addTimer:[self heartbeatTimer] forMode:NSEventTrackingRunLoopMode];
	}
}

- (void)stopAnimation
{
	[[self heartbeatTimer] invalidate];
	[self setHeartbeatTimer:nil];
	[self animate:nil];
}

- (void)animate:(NSTimer *)aTimer
{
	NSTableView *tableView = [tableColumn tableView];
	if ([[tableView window] isVisible]) {
		id cell = [tableColumn dataCell];
		double value = fmod(([cell doubleValue] + (5.0/60.0)), 1.0);
		[cell setDoubleValue:value];
		// redraw column
		int columnIndex = [[tableView tableColumns] indexOfObject:tableColumn];
		NSRect redrawRect = [tableView rectOfColumn:columnIndex];
		[tableView setNeedsDisplayInRect:redrawRect];
	}
}


@end
