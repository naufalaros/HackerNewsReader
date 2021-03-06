//
//  HNStore.m
//  HackerNewsNetworker
//
//  Created by Ryan Nystrom on 4/6/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

#import "HNDiskStore.h"

@implementation HNDiskStore

+ (NSString *)archivePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths firstObject];
    return documentsPath;
}

- (instancetype)initWithCacheName:(NSString *)cacheName {
    NSParameterAssert(cacheName != nil);
    if (self = [super init]) {
        _cachePath = [[self.class archivePath] stringByAppendingPathComponent:cacheName];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%p %@ - %@>",self,NSStringFromClass(self.class),self.cachePath];
}

- (id <NSCoding>)fetchFromDisk {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:self.cachePath];
}

- (BOOL)archiveToDisk:(id <NSCoding>)object {
    NSParameterAssert(object != nil);
    return [NSKeyedArchiver archiveRootObject:object toFile:self.cachePath];
}

@end
