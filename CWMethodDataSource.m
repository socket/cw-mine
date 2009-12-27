//
//  CWMethodDataSource.m
//  MMCourseWork
//
//  Created by Alexey Streltsow on 12/1/09.
//  Copyright 2009 Karma World LLC. All rights reserved.
//

#import "CWMethodDataSource.h"
#import "CWMethodOperation.h"
#import "CWMatrixLUDecOperation.h"
#import "CWParabolaOperation.h"
#import "CWMatrixQRDecOperation.h"
#import "CWMatrixLUDecCroutOperation.h"
#import "CWMatrixLUDecGaussOperation.h"

@implementation CWMethodDataSource

+ (NSArray*) useableMethodArray {
	return [[NSArray arrayWithObjects:
			 [CWMatrixLUDecOperation class], [CWMatrixQRDecOperation class], [CWMatrixLUDecCroutOperation class], 
			 [CWMatrixLUDecGaussOperation class], [CWParabolaOperation class], nil] 
			retain];
}

@end
