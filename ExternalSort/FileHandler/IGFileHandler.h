//
//  IGFileHandler.h
//  ExternalSort
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGFileHandler : NSObject {
    FILE *file;
    const char *name;
}

- (id)initForReadingWithFilePath:(const char *)filePath;
- (id)initForWritingWithFilePath:(const char *)filePath;
- (unsigned long)calculateFileLength;

- (FILE *)file;

-(void)closeFile;
-(void)removeFile;

@end
