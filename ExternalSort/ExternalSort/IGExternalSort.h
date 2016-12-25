//
//  IGExternalSort.h
//  ExternalSort
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGExternalSort : NSObject

- (void)sortInputFilePath:(const char *)inputFilePath outputFilePath:(const char *)outputFilePath availableMemory:(int)availableMemory;

@end
