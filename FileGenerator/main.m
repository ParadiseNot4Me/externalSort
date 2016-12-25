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
    if (argc < 2) {
        printf("Use arguments. help - readme.md\n");
    }
    
    [IGFileGenerator generateBinaryFileAtPath:argv[2] withSize:atoi(argv[3])*1000*1000];
    
    return 0;
}
