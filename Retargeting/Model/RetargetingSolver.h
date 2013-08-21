//
//  RetargetingSolver.h
//  Retargeting
//
//  Created by Daniel Graf on 23.10.12.
//  Copyright (c) 2012 Daniel Graf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Matrix.h"
#import "SparseMatrix.h"
#import "FastCCSMatrix.h"
#import "RetargetingTask.h"
#import "Types.h"
@interface RetargetingSolver : NSObject
-(RetargetingTask *)solveAndPostprocessWithTask:(RetargetingTask *)task;
-(RetargetingTask *)solveWithCropping:(RetargetingTask *)task;
-(RetargetingTask *)solveASAPWithTask:(RetargetingTask *)task;
@end
