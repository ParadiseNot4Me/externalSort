//
//  IGExternalSort.m
//  ExternalSort
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import "IGExternalSort.h"
#import "IGFileHandler.h"
#import "IGPriorityQueue.h"

@interface IGExternalSort ()

@property (nonatomic, strong) IGFileHandler *inputFileHandler;
@property (nonatomic, strong) IGFileHandler *outputFileHandler;

@property (nonatomic, assign) int blockCount;
@property (nonatomic, assign) int availableMemory;
@property (nonatomic, assign) BOOL binary;
@property (nonatomic, strong) NSMutableArray *tmpFiles;

@end

@implementation IGExternalSort

- (void)sortInputFilePath:(const char *)inputFilePath outputFilePath:(const char *)outputFilePath availableMemory:(int)availableMemory binary:(BOOL)binary {
    self.inputFileHandler = [[IGFileHandler alloc] initForReadingWithFilePath:inputFilePath];
    self.outputFileHandler = [[IGFileHandler alloc] initForWritingWithFilePath:outputFilePath];
    self.blockCount = [self calculateBlockCount:[self.inputFileHandler calculateFileLength] availableMemory:availableMemory];
    self.availableMemory = availableMemory;
    self.binary = binary;
    
    [self generateTempFiles];
    [self blockSort];
    [self mergeSort];
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
        IGFileHandler *tmpFileHandler = self.tmpFiles[i];
        
        if (self.binary) {
            size_t bytesRead = fread(buffer, 1, self.availableMemory, self.inputFileHandler.file);
            qsort(buffer, bytesRead / sizeof(double), sizeof(double), compareFunction);
            fwrite(buffer, bytesRead, 1, tmpFileHandler.file);
        } else {
            unsigned long fileSize = 0;
            int count = 0;
            double number = 0.0;
            while (fileSize < self.availableMemory && (fscanf(self.inputFileHandler.file,"%lf",&number) != EOF)) {
                buffer[count] = number;
                int bytesRead = snprintf(NULL, 0, "%lf\n",number);
                fileSize += bytesRead;
                count++;
            }
            
            qsort(buffer, count, sizeof(double), compareFunction);
            
            for (int k = 0; k < count; k++) {
                char *numberBuffer = malloc((sizeof(char) * snprintf(NULL, 0, "%lf\n",buffer[k])) + 1);
                sprintf(numberBuffer, "%lf\n",buffer[k]);
                fprintf(tmpFileHandler.file, "%s", numberBuffer);
                free(numberBuffer);
            }
        }
        
        free(buffer);
    }
    
    for (IGFileHandler *tmpFile in self.tmpFiles) {
        fseek(tmpFile.file, SEEK_SET, 0);
    }
}

-(void)mergeSort {
    IGPriorityQueue *priorityQueue = [IGPriorityQueue new];
    
    for (IGFileHandler *tmpFile in self.tmpFiles) {
        double priority;
        
        if (self.binary) {
            fread(&priority,1, sizeof(double), tmpFile.file);
        } else {
            fscanf(tmpFile.file, "%lf",&priority);
        }
        
        IGPriorityQueueNode *priorityQueueNode = [[IGPriorityQueueNode alloc] initWithFile:tmpFile priority:priority];
        [priorityQueue enqueueNode:priorityQueueNode];
    }
    
    while (priorityQueue.size > 0) {
        IGPriorityQueueNode *priorityQueueNode = [priorityQueue dequeueNode];
        
        double priority = priorityQueueNode.priority;
        
        if (self.binary) {
            fwrite(&priority, sizeof(double), 1, self.outputFileHandler.file);
        } else {
            char *numberBuffer = malloc((sizeof(char) * snprintf(NULL, 0, "%lf\n", priority)) + 1);
            sprintf(numberBuffer, "%lf\n", priority);
            fprintf(self.outputFileHandler.file, "%s", numberBuffer);
            free(numberBuffer);
            
        }

        BOOL isFileEnd = NO;
        
        if (self.binary) {
            size_t byte = fread(&priority, 1, sizeof(double), priorityQueueNode.fileHandler.file);
            if (byte == 0) isFileEnd = YES;
        } else {
            if ((fscanf(priorityQueueNode.fileHandler.file, "%lf",&priority) == EOF)) {
                isFileEnd = YES;
            }
        }

        if (!isFileEnd) {
            priorityQueueNode.priority = priority;
            
            [priorityQueue enqueueNode:priorityQueueNode];
        } else {
            [priorityQueueNode.fileHandler closeFile];
            [priorityQueueNode.fileHandler removeFile];
        }
    }
}

int compareFunction (const void * a, const void * b) {
    return (*(double*)a - *(double*)b);
}

@end
