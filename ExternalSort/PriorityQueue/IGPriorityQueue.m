//
//  IGPriorityQueue.m
//  ExternalSort
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import "IGPriorityQueue.h"
#import "IGFileHandler.h"

@interface IGPriorityQueue ()

@property (nonatomic, strong) NSMutableArray *queue;

@end

@implementation IGPriorityQueue

- (id)init {
    if (self = [super init]) {
        _queue = [NSMutableArray new];
    }
    return self;
}

-(void)enqueueNode:(IGPriorityQueueNode *)node {
    [self.queue addObject:node];
}

-(IGPriorityQueueNode *)dequeueNode {
    IGPriorityQueueNode *node = [self.queue firstObject];
    [self.queue removeObject:node];
    return node;
}

- (NSUInteger)size {
    return self.queue.count;
}

@end

@implementation IGPriorityQueueNode

- (id)initWithFile:(IGFileHandle *)file priority:(double)priority {
    self = [super init];
    if (self != nil) {
        self.file = file;
        self.priority = priority;
    }
    return self;
    
}

@end
