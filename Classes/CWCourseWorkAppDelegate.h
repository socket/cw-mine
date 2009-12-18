//
//  MMCourseWorkAppDelegate.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrixInputController.h"
#import "CWSolutionWindowController.h"

@interface CWCourseWorkAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	CWMatrixInputController*	_matrixInputController;
	CWSolutionWindowController* _solutionController;
}

- (IBAction) showMatrixInputWindow:	(id)sender;
- (IBAction) showSolutionWindow:	(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
