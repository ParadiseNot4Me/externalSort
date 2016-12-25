//
//  IGExternalSort.m
//  ExternalSort
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import "IGExternalSort.h"
#import "IGFileHandler.h"

@interface IGExternalSort ()

@property (nonatomic, strong) IGFileHandler *inputFileHandler;
@property (nonatomic, strong) IGFileHandler *outputFileHandler;

@property (nonatomic, assign) int blockCount;
@property (nonatomic, assign) int availableMemory;
@property (nonatomic, strong) NSMutableArray *tmpFiles;

@end

@implementation IGExternalSort

- (void)sortInputFilePath:(const char *)inputFilePath outputFilePath:(const char *)outputFilePath availableMemory:(int)availableMemory {
    self.inputFileHandler = [[IGFileHandler alloc] initForReadingWithFilePath:inputFilePath];
    self.outputFileHandler = [[IGFileHandler alloc] initForWritingWithFilePath:outputFilePath];
    self.blockCount = [self calculateBlockCount:[self.inputFileHandler calculateFileLength] availableMemory:availableMemory];
    self.availableMemory = availableMemory;
    
    [self generateTempFiles];
    [self blockSort];
}

- (int)calculateBlockCount:(unsigned long)fileLength availableMemory:(int)availableMemory {
    int blockCount = (int)(fileLength/availableMemory);
    return blockCount;
}

-(void)generateTempFiles {
    self.tmpFiles = [NSMutableArray new];
    
    for (int i = 0; i < self.blockCount; i++) {
        char *tmp_char = malloc(sizeof(int));
        sprintf(tmp_char, "%d", i);
        
        char *filePath = malloc(strlen("./tmpfile_")
                                + strlen(tmp_char)
                                + strlen(".txt") + 1);
        
        strcpy(filePath, "./tmpFile_");
        strcat(filePath, tmp_char);
        strcat(filePath, ".txt");
        
        IGFileHandler *fileHandler = [[IGFileHandler alloc] initForWritingWithFilePath:filePath];
        [self.tmpFiles addObject:fileHandler];
    }
}

-(void)blockSort {
    for (int i = 0; i <self.blockCount; i++) {
        double *buffer = (double *)malloc(self.availableMemory);
        
        size_t bytesRead = fread(buffer, 1, self.availableMemory, self.inputFileHandler.file);
        qsort(buffer, bytesRead / sizeof(double), sizeof(double), compareFunction);
        IGFileHandler *tmpFileHandler = self.tmpFiles[i];
        fwrite(buffer, bytesRead, 1, tmpFileHandler.file);
        
        free(buffer);
    }
    
    for (IGFileHandler *tmpFile in self.tmpFiles) {
        fseek(tmpFile.file, SEEK_SET, 0);
    }
}

int compareFunction (const void * a, const void * b) {
    return (*(double*)a - *(double*)b);
}

@end