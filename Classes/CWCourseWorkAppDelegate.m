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

@implementation CWCourseWorkAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	_matrixInputController = [[CWMatrixInputController alloc] initWithWindowNibName:@"CWMatrixInputController"];	
	_solutionController = [[CWSolutionWindowController alloc] initWithWindowNibName:@"CWSolutionWindowController"];
	
	CWMatrix* matTest1 = [CWMatrix matrixWithRows:2 columns:2];
	[matTest1 setValue:1 row:0 column:0];
	[matTest1 setValue:2 row:1 column:0];
	[matTest1 setValue:3 row:0 column:1];
	[matTest1 setValue:4 row:1 column:1];
	NSLog(@"%@", [matTest1 description]);
	CWMatrix* matTest2 = [matTest1 multiplyByScalar:2.0];
	NSLog(@"%@", [matTest2 description]);
	CWMatrix* matTest3 = [matTest1 multiplyByMatrix:matTest2];
	NSLog(@"%@", [matTest3 description]);
	
}

- (IBAction) showMatrixInputWindow:(id)sender {
	[_matrixInputController showWindow:self];
}

- (IBAction) showSolutionWindow:(id)sender {
	[_solutionController showWindow:self];
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
