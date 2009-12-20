//
//  CWNewPlotWindowController.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/21/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString* const kNotificationAddPlotMethod;

@interface CWAddPlotWindowController : NSWindowController<NSComboBoxDelegate> {
	// add/edit method pane
	NSButton*					_methodAddButton;
	NSComboBox*				_methodNameComboBox;
	NSComboBox*				_methodKeyComboBox;
	NSColorWell*			_methodColor;
	NSTextField*			_methodPrecision;
}

+ controller;

- (IBAction)performAdd:(id)sender;

@property (nonatomic, retain) IBOutlet NSButton*			methodAddButton;
@property (nonatomic, retain) IBOutlet NSComboBox*			methodNameComboBox;
@property (nonatomic, retain) IBOutlet NSComboBox*			methodKeyComboBox;
@property (nonatomic, retain) IBOutlet NSColorWell*			methodColor;
@property (nonatomic, retain) IBOutlet NSTextField*			methodPrecision;

@end
