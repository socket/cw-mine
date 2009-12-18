//
//  CWMatrixDataSource.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrix.h"

@interface CWMatrixDataSource : NSObject<NSTableViewDataSource> {
	@protected
	CWMatrix* _matrix;
}

+(id) dataSourceWithMatrix:(CWMatrix*)matrix;
- (id) initWithMatrix:(CWMatrix*)matrix;

@property (nonatomic, readonly) CWMatrix* matrix;

@end
