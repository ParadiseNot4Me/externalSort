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
    [self insertObjectUsingBinarySearch:node];
}

-(IGPriorityQueueNode *)dequeueNode {
    IGPriorityQueueNode *node = [self.queue firstObject];
    [self.queue removeObject:node];
    return node;
}

- (NSUInteger)size {
    return self.queue.count;
}

- (void)insertObjectUsingBinarySearch:(IGPriorityQueueNode *)node
{
    if (self.size == 0) {
        [self.queue addObject:node];
        return;
    }
    
    int mid = 0;
    int min = 0;
    int max = (int)self.queue.count - 1;
    
    BOOL found = NO;
    
    while (min <= max) {
        
        mid = (max + min) / 2;
        
        
        IGPriorityQueueNode *tmpNode = self.queue[mid];
        
        if(node.priority == tmpNode.priority){
            mid++;
            found = YES;
            break;
        }
        else if (node.priority < tmpNode.priority){
            max = mid - 1;
        }
        else if (node.priority > tmpNode.priority){
            min = mid + 1;
        }
    }
    
    if (found) {
        [self.queue insertObject:node atIndex:mid];
    } else {
        [self.queue insertObject:node atIndex:min];
    }
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
