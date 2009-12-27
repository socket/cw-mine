//
//  MMCourseWorkAppDelegate.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWCourseWorkAppDelegate.h"

#import "CWMatrix.h"
#import "CWMatrixLUDecOperation.h"
#import "CWMatrixInitializer.h"

#import "CWDecompositionController.h"
#import "CWGraphicWindowController.h"

#import "CWLUDecomposition.h"

@implementation CWCourseWorkAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	_matrixInputController = [[CWMatrixInputController alloc] initWithWindowNibName:@"CWMatrixInputController"];	
	_solutionController = [[CWSolutionWindowController alloc] initWithWindowNibName:@"CWSolutionWindowController"];
}

- (IBAction) showMatrixInputWindow:(id)sender {
	[_matrixInputController showWindow:self];
}

- (IBAction) showSolutionWindow:(id)sender {
	[_solutionController showWindow:self];
}


- (IBAction) showGraphWindow:(id)sender {
	CWGraphicWindowController* controller = [[CWGraphicWindowController alloc] initWithWindowNibName:@"CWGraphicWindowController"];
	[controller showWindow:self];
	// FIXME: memory leak
}

- (IBAction) showDecomposeWindow:(id)sender {
	CWDecompositionController* controller = [[CWDecompositionController alloc] initWithWindowNibName:@"CWDecompositionController"];
	[controller showWindow:self];
	// FIXME: memory leak
}

- (void) dealloc {
	[_matrixInputController release];
	[_solutionController release];
	
	[super dealloc];
}
@end
