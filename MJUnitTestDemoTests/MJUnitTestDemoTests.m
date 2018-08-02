//
//  MJUnitTestDemoTests.m
//  MJUnitTestDemoTests
//
//  Created by MinJing_Lin on 2018/8/1.
//  Copyright © 2018年 MinJing_Lin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFNetworking.h"

#define WAIT do {\
[self expectationForNotification:@"MJUnitTest" object:nil handler:nil];\
[self waitForExpectationsWithTimeout:30 handler:nil];\
} while (0);
// waitForExpectationsWithTimeout是等待时间，超过了就不再等待往下执行。
#define NOTIFY \
[[NSNotificationCenter defaultCenter]postNotificationName:@"MJUnitTest" object:nil];

@interface MJUnitTestDemoTests : XCTestCase

@end

@implementation MJUnitTestDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // NSLog(@"自定义测试 testExample");
    NSInteger a = 5;
    NSInteger b = 5;
    XCTAssertEqual(a, b, "a不等于b");
}

- (void)testRequest{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = @"http://www.weather.com.cn/data/cityinfo/101190401.html";
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        XCTAssertNotNil(responseObject, @"返回出错");
        NOTIFY //继续执行
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error:%@",error);
        XCTAssertNil(error, @"请求出错");
        NOTIFY //继续执行
        
    }];
    WAIT   //暂停
}

- (void)testRequest2{
    
    XCTestExpectation *exp = [self expectationWithDescription:@"接口请求失败。。。"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *urlStr = @"http://www.weather.com.cn/data/cityinfo/101190401.html";
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject2:%@",responseObject);
        XCTAssertNotNil(responseObject, @"返回出错");
        //如果断言没问题，就调用fulfill宣布测试满足
        [exp fulfill];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error:%@",error);
        XCTAssertNil(error, @"请求出错");
        
        [exp fulfill];
        
    }];
    
    //设置延迟多少秒后，如果没有满足测试条件就报错
    [self waitForExpectationsWithTimeout:15 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

// 生成在[base, end]之间的随机数
- (int)randomNumberFrom: (int)base End: (int)top{
    if (base >= top) {
        return base;
    }
    return (arc4random() % (top - base + 1)) + base;
}

- (void)testRandom{
    int base = 3;
    int top = 80;
    
    for (int i=0; i<100; i++) {
        int temp = [self randomNumberFrom:base End:top];
        if (temp < base || temp > top) {
            XCTFail(@"invalid num = %d",temp);
        }
    }
}

- (void)testPerformanceExample {
    
    [self measureBlock:^{
        
        NSMutableArray * mutArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9999; i++) {
            NSObject * object = [[NSObject alloc] init];
            [mutArray addObject:object];
        }
    }];
}

/* 测试各个断言 */
- (void)testAssert {
    //     XCTFail(format…) 生成一个失败的测试；
    //    XCTFail(@"Fail");
    
    
    // XCTAssertNil(a1, format...) 为空判断， a1 为空时通过，反之不通过；
    //    XCTAssertNil(@"not nil string", @"string must be nil");
    
    
    // XCTAssertNotNil(a1, format…) 不为空判断，a1不为空时通过，反之不通过；
    //    XCTAssertNotNil(@"not nil string", @"string can not be nil");
    
    
    // XCTAssert(expression, format...) 当expression求值为TRUE时通过；
    //    XCTAssert((2 > 2), @"expression must be true");
    
    
    // XCTAssertTrue(expression, format...) 当expression求值为TRUE时通过；
    //    XCTAssertTrue(1, @"Can not be zero");
    
    
    // XCTAssertFalse(expression, format...) 当expression求值为False时通过；
    //    XCTAssertFalse((2 < 2), @"expression must be false");
    
    
    // XCTAssertEqualObjects(a1, a2, format...) 判断相等， [a1 isEqual:a2] 值为TRUE时通过，其中一个不为空时，不通过；
    //    XCTAssertEqualObjects(@"1", @"1", @"[a1 isEqual:a2] should return YES");
    //    XCTAssertEqualObjects(@"1", @"2", @"[a1 isEqual:a2] should return YES");
    
    
    //     XCTAssertNotEqualObjects(a1, a2, format...) 判断不等， [a1 isEqual:a2] 值为False时通过，
    //    XCTAssertNotEqualObjects(@"1", @"1", @"[a1 isEqual:a2] should return NO");
    //    XCTAssertNotEqualObjects(@"1", @"2", @"[a1 isEqual:a2] should return NO");
    
    
    // XCTAssertEqual(a1, a2, format...) 判断相等（当a1和a2是 C语言标量、结构体或联合体时使用,实际测试发现NSString也可以）；
    // 1.比较基本数据类型变量
    //    XCTAssertEqual(1, 2, @"a1 = a2 shoud be true"); // 无法通过测试
    //    XCTAssertEqual(1, 1, @"a1 = a2 shoud be true"); // 通过测试
    
    // 2.比较NSString对象
    //    NSString *str1 = @"1";
    //    NSString *str2 = @"1";
    //    NSString *str3 = str1;
    //    XCTAssertEqual(str1, str2, @"a1 and a2 should point to the same object"); // 通过测试
    //    XCTAssertEqual(str1, str3, @"a1 and a2 should point to the same object"); // 通过测试
    
    // 3.比较NSArray对象
    //    NSArray *array1 = @[@1];
    //    NSArray *array2 = @[@1];
    //    NSArray *array3 = array1;
    //    XCTAssertEqual(array1, array2, @"a1 and a2 should point to the same object"); // 无法通过测试
    //    XCTAssertEqual(array1, array3, @"a1 and a2 should point to the same object"); // 通过测试
    
    
    // XCTAssertNotEqual(a1, a2, format...) 判断不等（当a1和a2是 C语言标量、结构体或联合体时使用）；
    
    
    // XCTAssertEqualWithAccuracy(a1, a2, accuracy, format...) 判断相等，（double或float类型）提供一个误差范围，当在误差范围（+/- accuracy ）以内相等时通过测试；
    //    XCTAssertEqualWithAccuracy(1.0f, 1.5f, 0.25f, @"a1 = a2 in accuracy should return YES");
    
    
    // XCTAssertNotEqualWithAccuracy(a1, a2, accuracy, format...) 判断不等，（double或float类型）提供一个误差范围，当在误差范围以内不等时通过测试；
    //    XCTAssertNotEqualWithAccuracy(1.0f, 1.5f, 0.25f, @"a1 = a2 in accuracy should return NO");
    
    
    // XCTAssertThrows(expression, format...) 异常测试，当expression发生异常时通过；反之不通过；（很变态）
    
    
    // XCTAssertThrowsSpecific(expression, specificException, format...) 异常测试，当expression发生 specificException 异常时通过；反之发生其他异常或不发生异常均不通过；
    
    // XCTAssertThrowsSpecificNamed(expression, specificException, exception_name, format...) 异常测试，当expression发生具体异常、具体异常名称的异常时通过测试，反之不通过；
    
    
    // XCTAssertNoThrow(expression, format…) 异常测试，当expression没有发生异常时通过测试；
    
    
    // XCTAssertNoThrowSpecific(expression, specificException, format...)异常测试，当expression没有发生具体异常、具体异常名称的异常时通过测试，反之不通过；
    
    
    // XCTAssertNoThrowSpecificNamed(expression, specificException, exception_name, format...) 异常测试，当expression没有发生具体异常、具体异常名称的异常时通过测试，反之不通过
}

@end
