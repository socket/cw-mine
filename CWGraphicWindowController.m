//
//  CWGraphicWindowController.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWGraphicWindowController.h"

@interface CWGraphicWindowController ( )
- (void) populateMethodClasses;

@end;

@implementation CWGraphicWindowController

@synthesize graphListTableView = _graphListTableView;
@synthesize addButton = _addButton;
@synthesize removeButton = _removeButton;

- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		
	}
	return self;
}

- (void) dealloc {
	[super dealloc];
}

- (void) populateMethodClasses {
	
}

#pragma mark -
#pragma mark actions


- (IBAction) addMethod:(id)sender {
	
}

- (IBAction) removeMethod:(id)sender {
	
}

@end
