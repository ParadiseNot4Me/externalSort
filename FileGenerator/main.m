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
    
    if(!strcmp(argv[1], "-b")) {
        [IGFileGenerator generateBinaryFileAtPath:argv[2] withSize:atoi(argv[3])*1000*1000];
    }
    if(!strcmp(argv[1], "-t")) {
        [IGFileGenerator generateTextFileAtPath:argv[2] withSize:atoi(argv[3])*1000*1000];
    }
    
    return 0;
}
