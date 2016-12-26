//
//  IGFileGenerator.m
//  ExternalSort
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import "IGFileGenerator.h"

@implementation IGFileGenerator

+ (void)generateBinaryFileAtPath:(const char *)filePath withSize:(unsigned long)totalSize {
    FILE *file = fopen(filePath, "w");
    
    unsigned long fileSize = 0;
    
    while (fileSize < totalSize) {
        double number = [self generateRandomDouble];
        fwrite(&number, sizeof(double), 1, file);
        
        fileSize += sizeof(double);
    }
    
    fclose(file);
}

+ (void)generateTextFileAtPath:(const char *)filePath withSize:(unsigned long)totalSize {
    FILE *file = fopen(filePath, "w");
    
    unsigned long fileSize = 0;
    
    while (fileSize < totalSize) {
        double number = [self generateRandomDouble];
        char *buffer = malloc((sizeof(char) * snprintf(NULL, 0, "%lf\n",number)) + 1);
        sprintf(buffer, "%lf\n",number);
        fprintf(file, "%s", buffer);
        
        fileSize += strlen(buffer);
        free(buffer);
    }
    
    fclose(file);
}

+ (double)generateRandomDouble {
    return (((double)rand()/(double)RAND_MAX) + (double)rand());
}

@end
