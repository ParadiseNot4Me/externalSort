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
    self.blockCount = [self calculateBlockCount:[self.inputFile calculateFileLength] availableMemory:availableMemory];
    self.availableMemory = availableMemory;
    
    [self generateTempFiles];
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

@end
