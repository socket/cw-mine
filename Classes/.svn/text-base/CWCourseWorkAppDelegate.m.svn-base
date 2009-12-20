//
//  MMCourseWorkAppDelegate.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWCourseWorkAppDelegate.h"

#import "CWMatrix.h"
#import "CWMatrixLUDecomposition.h"
#import "CWMatrixInitializer.h"

@implementation CWCourseWorkAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	_matrixInputController = [[CWMatrixInputController alloc] initWithWindowNibName:@"CWMatrixInputController"];	
	_solutionController = [[CWSolutionWindowController alloc] initWithWindowNibName:@"CWSolutionWindowController"];
	
	// Test code
	CWMatrix* matrix = [CWMatrixInitializer randomMatrixWithRank:3]; //[CWMatrixInitializer matrixWithRank:5 qCoeff:0.994];
	CWMatrixLUDecomposition* ludec = [[[CWMatrixLUDecomposition alloc] init] autorelease];
	ludec.srcMatrix = matrix;
	/*
	[matrix setElementValue:[NSNumber numberWithInt:4] atRow:0 andColumn:0];
	[matrix setElementValue:[NSNumber numberWithInt:5] atRow:1 andColumn:0];
	[matrix setElementValue:[NSNumber numberWithInt:6] atRow:2 andColumn:0];
	[matrix setElementValue:[NSNumber numberWithInt:7] atRow:0 andColumn:1];
	[matrix setElementValue:[NSNumber numberWithInt:8] atRow:1 andColumn:1];
	[matrix setElementValue:[NSNumber numberWithInt:9] atRow:2 andColumn:1];
	[matrix setElementValue:[NSNumber numberWithInt:10] atRow:0 andColumn:2];
	[matrix setElementValue:[NSNumber numberWithInt:11] atRow:1 andColumn:2];
	[matrix setElementValue:[NSNumber numberWithInt:12] atRow:2 andColumn:2];
	*/
	[matrix debugTrace];
	
	[ludec main];
	[ludec cancel];
}

- (IBAction) showMatrixInputWindow:(id)sender {
	[_matrixInputController showWindow:self];
}

- (IBAction) showSolutionWindow:(id)sender {
	[_solutionController showWindow:self];
}

- (void) dealloc {
	[_matrixInputController release];
	[_solutionController release];
	
	[super dealloc];
}
@end
