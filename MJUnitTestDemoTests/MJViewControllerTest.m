//
//  MJViewControllerTest.m
//  MJUnitTestDemoTests
//
//  Created by MinJing_Lin on 2018/8/2.
//  Copyright © 2018年 MinJing_Lin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface MJViewControllerTest : XCTestCase
@property (nonatomic, strong) ViewController *VC;
@end

@implementation MJViewControllerTest

- (void)setUp {
    [super setUp];
    //初始化，在测试方法调用之前调用
    self.VC = [[ViewController alloc]init];
}

- (void)tearDown {
    self.VC = nil;
    
    // 释放测试用例的资源代码，这个方法会每个测试用例执行后调用
    [super tearDown];
}

- (void)testGetNum{
    int result = [self.VC getNum];
    
    XCTAssertEqual(result, 100, @"不相等，测试不通过");
}

- (void)testExample {
    // 测试用例的例子，注意测试用例一定要test开头
}

- (void)testPerformanceExample {
    [self measureBlock:^{
        // 需要测试性能的代码
    }];
}

@end
