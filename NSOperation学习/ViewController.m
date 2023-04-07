//
//  ViewController.m
//  NSOperation学习
//
//  Created by 翟旭博 on 2023/4/5.
//

#import "ViewController.h"
#import "MYOperation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self nSInvocationOperation];    //使用子类NSInvocationOperation
    //[self nSBlockOperation];   //使用子类NSBlockOperation
    //[self useBlockOperationAddExecutionBlock];   //为 NSBlockOperation 添加额外的操作
    //[self useMYOperation];   //使用自定义继承自 NSOperation 的子类
    //[self nSOperationQueueAddOperation];
    //[self nSOperationQueueAddOperationWithBlock];
    //[self notAddDependency];   //不添加依赖
    //[self yesAddDependency];   //添加依赖
    //[self bothAddDependency];   //相互依赖
    //[self useQueuePriority];   //NSOperation优先级
    //[self communication];   //NSOperation通信
}
- (void)nSInvocationOperation {
    // 1.创建 NSInvocationOperation 对象
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(testOp) object:nil];
    // 2.调用 start 方法开始执行操作
    [op start];
}
- (void)testOp {
    NSLog(@"testOp--%@", [NSThread currentThread]);
}

- (void)nSBlockOperation {
    NSLog(@"----%@", [NSThread currentThread]); // 打印当前线程
    
    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"%d---%@", i, [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 2.调用 start 方法开始执行操作
    [op start];
}

/**
 * 使用子类 NSBlockOperation
 * 调用方法 AddExecutionBlock:
 */
- (void)useBlockOperationAddExecutionBlock {

    // 1.创建 NSBlockOperation 对象
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 2.添加额外的操作
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"5---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"6---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"7---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"8---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 3.调用 start 方法开始执行操作
    [op start];
}

- (void)useMYOperation {
    // 1.创建 MYOperation 对象
    MYOperation *my = [[MYOperation alloc] init];
    // 2.调用 start 方法开始执行操作
    [my start];
}

- (void)nSOperationQueueAddOperation{
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.创建操作
    NSInvocationOperation *firstOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationFirst) object:nil];
    NSBlockOperation *secondOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2---%@", [NSThread currentThread]);
    }];
    [secondOperation addExecutionBlock:^{
        NSLog(@"add--%@", [NSThread currentThread]);
    }];
    NSInvocationOperation *thirdOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationThird) object:nil];

    // 3.将操作加到队列中
    [queue addOperation:firstOperation];
    [queue addOperation:secondOperation];
    [queue addOperation:thirdOperation];
}
- (void)operationFirst {
    NSLog(@"1---%@", [NSThread currentThread]);
}
- (void)operationThird {
    NSLog(@"3---%@", [NSThread currentThread]);
}

- (void)nSOperationQueueAddOperationWithBlock {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    queue.maxConcurrentOperationCount = -1;  // 控制一次最多执行的线程数
    
    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1---%@", [NSThread currentThread]);
    }];

    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2---%@", [NSThread currentThread]);
    }];

    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3---%@", [NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4---%@", [NSThread currentThread]);
    }];
    
    [queue addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"5---%@", [NSThread currentThread]);
    }];
}

- (void)notAddDependency {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
    NSBlockOperation *firstOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"firstOperation");
    }];
    NSBlockOperation *secondOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"secondOperation");
    }];
    NSBlockOperation *thirdOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"thirdOperation");
    }];

    [queue addOperation:firstOperation];
    [queue addOperation:secondOperation];
    [queue addOperation:thirdOperation];
}
- (void)yesAddDependency {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    NSBlockOperation *firstOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"firstOperation");
    }];
    NSBlockOperation *secondOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"secondOperation");
    }];
    NSBlockOperation *thirdOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"thirdOperation");
    }];

    [secondOperation addDependency:firstOperation]; // 让secondOperation依赖于firstOperation，即firstOperation先执行，在执行secondOperation
    [thirdOperation addDependency:secondOperation]; // 让thirdOperation依赖于secondOperation，即secondOperation先执行，在执行thirdOperation

    [queue addOperation:firstOperation];
    [queue addOperation:secondOperation];
    [queue addOperation:thirdOperation];

}
- (void)bothAddDependency {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
    NSBlockOperation *firstOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"firstOperation");
    }];
    NSBlockOperation *secondOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"secondOperation");
    }];
    NSBlockOperation *thirdOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"thirdOperation");
    }];

    [secondOperation addDependency:firstOperation]; // 让secondOperation依赖于firstOperation，即firstOperation先执行，在执行secondOperation
    [firstOperation addDependency:secondOperation]; // 让firstOperation依赖于secondOperation，即secondOperation先执行，在执行firstOperation

    [queue addOperation:firstOperation];
    [queue addOperation:secondOperation];
    [queue addOperation:thirdOperation];

}

- (void)useQueuePriority {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    NSBlockOperation *firstOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"begin firstOperation");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"firstOperation end");
    }];
    firstOperation.queuePriority = NSOperationQueuePriorityLow;

    NSBlockOperation *secondOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"begin secondOperation");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"secondOperation end");
    }];
    secondOperation.queuePriority = NSOperationQueuePriorityHigh;

    NSBlockOperation *thirdOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"begin thirdOperation");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"thirdOperation end");
    }];
    thirdOperation.queuePriority = NSOperationQueuePriorityNormal;

    queue.maxConcurrentOperationCount = 3;


    [queue addOperation:firstOperation];
    [queue addOperation:secondOperation];
    [queue addOperation:thirdOperation];

}

- (void)communication {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 100, 200, 200);
    imageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:imageView];
    //1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //2.添加操作
    [queue addOperationWithBlock:^{
        // 1. 获取图片 imageUrl
        NSURL *imageUrl = [NSURL URLWithString:@"https://img-blog.csdnimg.cn/d317e3af47424e03bea4572b6fa4b917.png"];
        // 2. 从 imageUrl 中读取数据(下载图片) -- 耗时操作
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        // 通过二进制 data 创建 image
        UIImage *image = [UIImage imageWithData:imageData];
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [imageView setImage:image];   //UI操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }];
    }];
}
@end
