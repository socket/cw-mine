//
//  AMProgressIndicatorTableColumnController.h
//  IPICellTest
//
//  Created by Andreas on 23.01.07.
//  Copyright 2007 Andreas Mayer. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AMProgressIndicatorTableColumnController : NSObject {
	NSTableColumn *tableColumn;
	NSTimer *heartbeatTimer;
}

- (id)initWithTableColumn:(NSTableColumn *)column;

- (void)startAnimation;

- (void)stopAnimation;


@end
