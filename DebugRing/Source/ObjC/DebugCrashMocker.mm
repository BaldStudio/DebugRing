//
//  DebugCrashMocker.m
//  DebugRing
//
//  Created by crzorz on 2022/6/23.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

#import "DebugCrashMocker.h"
#import <objc/runtime.h>
#include <exception>
#include <string>

typedef struct class_ro_t {
    uint32_t flags;
    uint32_t instanceStart;
    uint32_t instanceSize;
#ifdef __LP64__
    uint32_t reserved;
#endif
    
    const uint8_t * ivarLayout;
    
    char * name;
    void * baseMethodList;
    void * baseProtocols;
    const void * ivars;
    
    const uint8_t * weakIvarLayout;
    void *baseProperties;
} class_ro_t;

typedef struct class_rw {
    uint32_t flags;
    uint32_t version;
    
    const class_ro_t *ro;
    
    void * methods;
    void * properties;
    void * protocols;
    
    Class firstSubclass;
    Class nextSiblingClass;
    
    char *demangledName;
} class_rw_t;

#if __LP64__
#define FAST_DATA_MASK          0x00007ffffffffff8UL
#else
#define FAST_DATA_MASK          0xfffffffcUL
#endif

// text_exception uses a dynamically-allocated internal c-string for what():
using namespace std;
class text_exception : public std::exception {
private:
    char* text_;
public:
    text_exception(const char* text) {
        text_ = new char[std::strlen(text) + 1];
        std::strcpy(text_, text);
    }
    text_exception(const text_exception& e) {
        text_ = new char[std::strlen(e.text_) + 1];
        std::strcpy(text_, e.text_);
    }
    const char* what() const _NOEXCEPT override {
        return (const char *)text_;
    }
};

// MARK: - Mocker

@interface DebugCrashMocker ()

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSArray *data;

@end

@implementation DebugCrashMocker

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupData];
        self.queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (NSArray<NSArray<NSString *> *> *)caseData {
    return self.data;
}

- (void)test_Overflow __attribute__ ((optnone)) {
    char a[200];
    [self test_Overflow];
    a[1] = 'b';
}

- (void)test_Overflow2 __attribute__ ((optnone)) {
    
    NSOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1 begin");
        sleep(1);
        NSLog(@"op1 end");
    }];
    
    NSOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op2 begin");
        sleep(1);
        NSLog(@"op2 end");
    }];
    
    NSOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op3 begin");
        sleep(1);
        NSLog(@"op3 end");
    }];
    
    [self.queue addOperation:op1];
    [op1 addDependency:op2];
    [op2 addDependency:op1];
    [op2 addDependency:op3];
    [op3 addDependency:op1];
    [self.queue addOperations:@[op2, op3] waitUntilFinished:NO];
    
}

- (void)test_NSException_array_beyound {
    id str = @[@"1"];
    [str objectAtIndex:1];
}

- (void)test_NSException_unrecognized_sel {
    id str = @"hehe";
    [str objectAtIndex:0];
}

- (void)test_NSException_dic {
    id source = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wignored-attributes"
#pragma clang diagnostic ignored "-Wunused-variable"
    __used NSDictionary *dic = @{
      @"file": source,
      @"line": @"12",
      @"column":@"co"
    };
#pragma clang diagnostic pop
}

- (void)test_CPPException_string {
    throw "This is a cpp exception string!";
}

- (void)test_CPPException_except {
    throw text_exception("This is a cpp exception");
}

- (void)test_CPPException_muti {
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            throw text_exception("This is a cpp exception");
        });
    }
    
}

- (void)test_SIGBUS_BUS_ADRALN  __attribute__ ((optnone)) {
    void (*func)(void) = (void(*)(void))(void *)((uintptr_t)(void *)NSLog + 1);
    func();
}

- (void)test_SIGBUS_00 __attribute__ ((optnone)) {
    void (*func)(void) = (void(*)(void))(void *)0x0;
    func();
}

- (void)test_SIGSEGV_00 __attribute__ ((optnone)) {
    char *ptr = (char *)(void *)0x0;
    *ptr = 'a';
}

- (void)test_SIGSEGV_wildPointer __attribute__ ((optnone)) {
    __unsafe_unretained NSMutableDictionary * hehe = nil;
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        hehe = dic;
        [hehe setObject:@"1" forKey:@"1"];
    }
    [hehe setObject:@"2" forKey:@"1"];
}

- (void)test_SIGSEGV_wildPointer_bg __attribute__ ((optnone)) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __unsafe_unretained NSMutableDictionary * hehe = nil;
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            hehe = dic;
            [hehe setObject:@"1" forKey:@"1"];
        }
        [hehe setObject:@"2" forKey:@"1"];
    });
}

- (void)test_SIGTRAP __attribute__ ((optnone)) {
    __builtin_trap();
}

- (void)test_abort __attribute__ ((optnone)) {
    abort();
}

- (void)test_MainCPUFull __attribute__ ((optnone)) {
    
    while (true) {
        void *a = calloc(1, 10 * 1024 * 1024);
        free(a);
    }
}

- (void)test_OOM __attribute__ ((optnone)) {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (true) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
            void *a = calloc(1, 1 * 1024 * 1024);
#pragma clang diagnostic pop
            sleep(0.2);
        }
    });
    
}

- (void)test_exit {
    exit(-1);
}

- (void)test_exit_bg {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        exit(-1);
    });
}

- (void)test_objc_fatal __attribute__ ((optnone)) {
    Class aCls = [self class];
    class_rw_t *aCls_rw = *(class_rw_t **)((uintptr_t)aCls + 4 * sizeof(uintptr_t));
    ((class_rw_t *)((uintptr_t)aCls_rw & FAST_DATA_MASK))->nextSiblingClass = aCls;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    _objc_flush_caches(nil);
#pragma clang diagnostic pop
}

- (void)test_SIGILL {
    dispatch_block_t block = [[self.data objectAtIndex:5] objectAtIndex:1];
    if (block) {
        block();
    }
}


static void test1() __attribute__ ((optnone)) {
    __builtin_trap();
}

- (void)test_Backtrace __attribute__ ((optnone)) {
    test1();
}

- (void)crashWhenBlockRelease {
    int a = 2;
    
    dispatch_block_t block = ^{
        printf("a:%d", a);
    };
    
    id obj = [block copy];
    
    __unsafe_unretained dispatch_block_t nextBlock = obj;
    
    block = nil;
    obj = nil;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    NSArray *arr = @[nextBlock];
#pragma clang diagnostic pop

    NSLog(@"obj: %@", obj);
}

- (void)testBlock:(dispatch_block_t)block {
    block();
    __builtin_trap();
}

- (void)crashWhenBlockRelease2 {
    int a = 2;
    
    [self testBlock:^{
        printf("a:%d", a);
    }];
}

void test(void) {
    test1();//. <- lr
    // crash
    // backtrace is wrong,
}


- (void)setupData {
    
    // Do any additional setup after loading the view.
    self.data = @[
      @[@"test (backtrace)",
        @"test_Backtrace"],
      
      @[@"NSException (数组越界)",
        @"test_NSException_array_beyound"],
      
      @[@"NSException (unrecognized selector)",
        @"test_NSException_unrecognized_sel"],
      
      @[@"NSException (dic nil)",
        @"test_NSException_dic"],
      
      @[@"CPP Exception (string)",
        @"test_CPPException_string"],
      
      @[@"CPP Exception (std::exception)",
        @"test_CPPException_except"],
      
      @[@"CPP Exception (并发多个)",
        @"test_CPPException_muti"],
      
      @[@"SIGBUS (BUS_ADRALN)",
        @"test_SIGBUS_BUS_ADRALN"],
      
      @[@"SIGBUS (0x0)",
        @"test_SIGBUS_00"],
      
      @[@"SIGSEGV (0x0)",
        @"test_SIGSEGV_00"],
      
      @[@"SIGSEGV (野指针)",
        @"test_SIGSEGV_wildPointer"],
      
      @[@"SIGSEGV (野指针子线程)",
        @"test_SIGSEGV_wildPointer_bg"],
      
      @[@"SIGTRAP",
        @"test_SIGTRAP"],
      
      @[@"SIGBART (abort)",
        @"test_abort"],
      
      @[@"SIGILL",
        @"test_SIGILL"],
      
      @[@"Stack overflow",
        @"test_Overflow"],
      
      @[@"Stack overflow2",
        @"test_Overflow2"],
      
      @[@"Crash _objc_Fatal",
        @"test_objc_fatal"],
      
      @[@"abort (内存打爆)",
        @"test_OOM"],
      
      @[@"abort (主线程卡死)",
        @"test_MainCPUFull"],
      
      @[@"exit",
        @"test_exit"],
      
      @[@"exit_bg",
        @"test_exit_bg"],
            
      @[@"crashWhenBlockRelease",
        @"crashWhenBlockRelease"],
    
      @[@"crashWhenBlockRelease2",
        @"crashWhenBlockRelease2"],
      
    ];
}

@end
