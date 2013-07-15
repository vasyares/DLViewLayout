//
//  UIView+DLViewLayout.h
//  UIViewLayoutExample
//
//  Created by Denis Lebedev on 15.07.13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DLViewLayout)

- (CGFloat)width;
- (instancetype)setWidth:(CGFloat)width;
- (CGFloat)height;
- (instancetype)setHeight:(CGFloat)height;
- (CGFloat)X;
- (instancetype)setX:(CGFloat)x;
- (CGFloat)Y;
- (instancetype)setY:(CGFloat)y;
- (CGPoint)origin;
- (instancetype)setOrigin:(CGPoint)origin;
- (CGSize)size;
- (instancetype)setSize:(CGSize)size;


- (instancetype)centerInSuperview;

- (instancetype)setRightOffset:(CGFloat)offset;


@end
