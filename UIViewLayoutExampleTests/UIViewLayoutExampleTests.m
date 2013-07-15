//
//  UIViewLayoutExampleTests.m
//  UIViewLayoutExampleTests
//
//  Created by Denis Lebedev on 15.07.13.
//  Copyright (c) 2013 Denis Lebedev. All rights reserved.
//

#import "UIViewLayoutExampleTests.h"

#import "UIView+DLViewLayout.h"

@interface UIViewLayoutExampleTests ()

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UIView *superView;

@end

@implementation UIViewLayoutExampleTests

- (void)setUp {
    [super setUp];
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
	self.superView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];

}

- (void)tearDown {
    [super tearDown];
}

- (void)testWidth {
	self.view.width = 99.f;
	CGFloat width = self.view.width;
	STAssertEquals(width, 99.f, @"Width should be equal");
	STAssertEquals(width, CGRectGetWidth(self.view.frame), @"Width should be equal");
}

- (void)testHeight {
	self.view.height = 99.f;
	CGFloat height = self.view.height;
	STAssertEquals(height, 99.f, @"Width should be equal");
	STAssertEquals(height, CGRectGetHeight(self.view.frame), @"Height should be equal");
}

- (void)testX {
	self.view.X = 99.f;
	CGFloat originX = self.view.X;
	STAssertEquals(originX, 99.f, @"Width should be equal");
	STAssertEquals(originX, CGRectGetMinX(self.view.frame), @"X should be equal");
}

- (void)testY {
	self.view.Y = 99.f;
	CGFloat height = self.view.Y;
	STAssertEquals(height, 99.f, @"Width should be equal");
	STAssertEquals(height, CGRectGetMinY(self.view.frame), @"Y should be equal");
}

- (void)testOrigin {
	self.view.origin = CGPointMake(99.f, 99.f);
	STAssertEquals(self.view.frame.origin, CGPointMake(99.f, 99.f), @"Origin should be equal");
}

- (void)testSize {
	self.view.size = CGSizeMake(99.f, 99.f);
	STAssertEquals(self.view.frame.size, CGSizeMake(99.f, 99.f), @"Size should be equal");
}

- (void)testRightOffset {
	[self.view setRightOffset:20];

	[self.superView addSubview:self.view];
	STAssertEquals(CGRectGetMaxX(self.view.frame) + 20, CGRectGetWidth(self.superView.frame), @"Offset should be equal to 20");
}

- (void)testCenterInSuperview {
	[self.view centerInSuperview];
	[self.superView addSubview:self.view];
	STAssertEquals(self.view.center, self.superView.center, @"View should be centered in superview after it's added as subview");
	
	self.view.width = 999;
	[self.view centerInSuperview];
	STAssertEquals(self.view.center, self.superView.center, @"View should be centered in existing superview");
}

@end
