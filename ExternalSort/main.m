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
        if (argc < 5) {
            printf("Use arguments. help - readme.md\n");
        }
        
        clock_t begin, end;
        begin = clock();
        
        IGExternalSort *externalSort = [IGExternalSort new];
        
        if(!strcmp(argv[1], "-b")) {
            [externalSort sortInputFilePath:argv[2] outputFilePath:argv[3] availableMemory:atoi(argv[4])*1000*1000 binary:YES];
        }
        if(!strcmp(argv[1], "-t")) {
            [externalSort sortInputFilePath:argv[2] outputFilePath:argv[3] availableMemory:atoi(argv[4])*1000*1000 binary:NO];
        }
        
        end = clock();
        double timeSpent = (double) (end - begin) / CLOCKS_PER_SEC;
        
        printf("input file: %s\n", argv[2]);
        printf("output file: %s\n", argv[3]);
        printf("available memory: %s\n", argv[4]);
        printf("time: %lf\n", timeSpent);
    }
    return 0;
}
