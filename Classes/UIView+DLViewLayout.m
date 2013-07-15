//
//  UIView+DLViewLayout.m
//  UIViewLayoutExample
//
//  Created by Denis Lebedev on 15.07.13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import "UIView+DLViewLayout.h"
#import <objc/runtime.h>

@interface UIView ()

@property (strong, nonatomic) NSMutableArray *deferredOperations;

@end

@implementation UIView (DLViewLayout)

- (NSMutableArray *)deferredOperations {
	return objc_getAssociatedObject(self, @selector(deferredOperations));
}

- (void)setDeferredOperations:(NSMutableArray *)deferredOperations {
	objc_setAssociatedObject(self, @selector(deferredOperations), deferredOperations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)width {
	return CGRectGetWidth(self.bounds);
}

- (instancetype)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
	return self;
}

- (CGFloat)height {
	return CGRectGetHeight(self.bounds);
}

- (instancetype)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
	return self;
}

- (CGFloat)X {
	return self.frame.origin.x;
}

- (instancetype)setX:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
	return self;
}

- (CGFloat)Y {
	return self.frame.origin.y;
}

- (instancetype)setY:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
	return self;
}

- (CGPoint)origin {
	return self.frame.origin;
}

- (instancetype)setOrigin:(CGPoint)origin {
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
	return self;
}

- (CGSize)size {
	return self.frame.size;
}

- (instancetype)setSize:(CGSize)size {
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
	return self;
}

- (instancetype)setRightOffset:(CGFloat)offset {
	if (self.superview) {
		self.X = self.superview.width - self.width - offset;
	} else {
		NSInvocation *invocation = [self addDeferredInvocationWithSelector:_cmd];
		[invocation setArgument:&offset atIndex:2];
	}
	return self;
}

- (instancetype)centerInSuperview {
	if (self.superview) {
		self.center = self.superview.center;
	} else {
		[self addDeferredInvocationWithSelector:_cmd];
	}
	return self;
}

#pragma mark - Private

- (NSInvocation *)addDeferredInvocationWithSelector:(SEL)selector {
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:selector]];
	[invocation setTarget:self];
	[invocation setSelector:selector];
	if (!self.deferredOperations) {
		self.deferredOperations = [NSMutableArray array];
	}
	[self.deferredOperations addObject:invocation];
	return invocation;
}

#pragma mark - Swizzling

- (void)vl_didMoveToSuperview {
	if (self.deferredOperations.count) {
		for (NSInvocation *invocation in self.deferredOperations) {
			[invocation invoke];
		}
		[self.deferredOperations removeAllObjects];
	}
	
	//UIView super
	[self vl_didMoveToSuperview];
}

+ (void)vl_swizzle {
	SEL didMoveToSuperview = @selector(didMoveToSuperview);
	SEL vldidMoveToSuperview = @selector(vl_didMoveToSuperview);
	method_exchangeImplementations(class_getInstanceMethod(self, didMoveToSuperview), class_getInstanceMethod(self, vldidMoveToSuperview));
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [self vl_swizzle];
        }
    });
}

@end
