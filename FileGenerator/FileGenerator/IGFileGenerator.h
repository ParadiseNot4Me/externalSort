//
//  IGFileGenerator.h
//  ExternalSort
//
//  Created by Иван Григорьев on 25.12.16.
//  Copyright © 2016 IG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IGFileGenerator : NSObject

+ (void)generateBinaryFileAtPath:(const char *)filePath withSize:(unsigned long)totalSize;

@end
