//
//  IGPriorityQueue.h
//  ExternalSort
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IGFileHandle;

@interface IGPriorityQueueNode : NSObject

@property (nonatomic, assign) double priority;
@property (nonatomic, strong) IGFileHandle *file;

- (id)initWithFile:(IGFileHandle *)file priority:(double)priority;

@end

@interface IGPriorityQueue : NSObject

-(void)enqueueNode:(IGPriorityQueueNode *)node;
-(IGPriorityQueueNode *)dequeueNode;

- (NSUInteger)size;

@end
