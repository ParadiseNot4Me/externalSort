//
//  main.m
//  FileGenerator
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGFileGenerator.h"

int main(int argc, const char * argv[]) {
    if (argc < 4) {
        printf("Use arguments. help - readme.md\n");
    }
    
    clock_t begin, end;
    begin = clock();
    
    if(!strcmp(argv[1], "-b")) {
        [IGFileGenerator generateBinaryFileAtPath:argv[2] withSize:atoi(argv[3])*1000*1000];
    }
    if(!strcmp(argv[1], "-t")) {
        [IGFileGenerator generateTextFileAtPath:argv[2] withSize:atoi(argv[3])*1000*1000];
    }
    
    end = clock();
    double timeSpent = (double) (end - begin) / CLOCKS_PER_SEC;
    
    printf("output file: %s\n", argv[2]);
    printf("size: %s\n", argv[3]);
    printf("time: %lf\n", timeSpent);

    return 0;
}
