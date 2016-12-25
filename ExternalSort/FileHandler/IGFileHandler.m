//
//  IGFileHandler.m
//  ExternalSort
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import "IGFileHandler.h"

@implementation IGFileHandler

- (id)initForReadingWithFilePath:(const char *)filePath {
    self = [super init];
    if (self != nil) {
        if (!filePath || strlen(filePath) <= 0) {
            return nil;
        }
        file = fopen(filePath, "rb");
        if (file == nil) {
            return nil;
        }
        name = filePath;
    }
    return self;
}

- (id)initForWritingWithFilePath:(const char *)filePath {
    self = [super init];
    if (self != nil) {
        if (!filePath || strlen(filePath) <= 0) {
            return nil;
        }
        file = fopen(filePath, "w+b");
        if (file == nil) {
            return nil;
        }
        name = filePath;
    }
    return self;
}

-(FILE *)file {
    return file;
}

- (unsigned long)calculateFileLength {
    unsigned long fileLength;
    fseek(file, 0, SEEK_END);
    fileLength = ftell(file);
    fseek(file, 0, SEEK_SET);
    return fileLength;
}
@end
