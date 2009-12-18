//
//  CWMatrixTableView.h
//  MMCourseWork
//
//  Created by Alexey Streltsow on 11/26/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CWMatrix.h"
#import "CWMatrixDataSource.h"

@interface CWMatrixTableView : NSTableView {
	@private
	CWMatrixDataSource* _matrixDataSource;
}

@property (nonatomic, assign) CWMatrix* matrix;

@end
