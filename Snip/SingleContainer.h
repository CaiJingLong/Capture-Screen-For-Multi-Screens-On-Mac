//
// Created by jinglong cai on 2021/4/7.
// Copyright (c) 2021 isee15. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSColor;

@interface SingleContainer : NSObject

@property(nonatomic, strong) NSColor *color;

+ (instancetype)shared;

- (void)changeColor:(NSColor *)color;

- (void)pickColor;
@end