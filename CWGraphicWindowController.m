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

@synthesize graphListTableView = _graphListTableView;
@synthesize addButton = _addButton;
@synthesize removeButton = _removeButton;

- (id) initWithWindowNibName:(NSString *)windowNibName {
	if ( self = [super initWithWindowNibName:windowNibName] ) {
		[self populateMethodClasses];
	}
	return self;
}

- (void) dealloc {
	[super dealloc];
}

- (void) populateMethodClasses {
	_methodsDataSource = [[NSArray arrayWithObjects:[CWMatrixLUDecOperation class], [CWMethodOperation class], nil] retain];
}

#pragma mark -
#pragma mark actions


- (IBAction) addMethod:(id)sender {
	
}

- (IBAction) removeMethod:(id)sender {
	
}

@end
