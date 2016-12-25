//
//  main.m
//  ExternalSort
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGExternalSort.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        IGExternalSort *externalSort = [IGExternalSort new];
        [externalSort sortInputFilePath:argv[2] outputFilePath:argv[3] availableMemory:atoi(argv[4])*1000*1000];
    }
    return 0;
}
