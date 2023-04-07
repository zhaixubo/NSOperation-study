//
//  MYOperation.m
//  NSOperation学习
//
//  Created by 翟旭博 on 2023/4/5.
//

#import "MYOperation.h"

@implementation MYOperation
- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }
}

- (void)start {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }
    [super start];
}

@end
