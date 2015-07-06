//
//  ViewController.m
//  GCDTest
//
//  Created by ceshi on 15/1/8.
//  Copyright (c) 2015年 ceshi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong)UIImageView *imageView;
@property(nonatomic, strong)UIButton    *queryBtn;
@property(nonatomic, strong)UIButton    *queryBtn1;
@property(nonatomic, strong)UIButton    *queryBtn2;
@property(nonatomic, strong)UIButton    *queryBtn3;
@property(nonatomic, strong)UIButton    *queryBtn4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addView];
    /*
    dispatch_sync，它干的事儿和dispatch_async相同，但是它会等待block中的代码执行完成并返回。结合 __block类型修饰符，可以用来从执行中的block获取一个值。例如，你可能有一段代码在后台执行，而它需要从界面控制层获取一个值。那么你可以使用dispatch_sync简单办到：
    
    __block NSString *stringValue;
    dispatch_sync(dispatch_get_main_queue(), ^{
        // __block variables aren't automatically retained
        // so we'd better make sure we have a reference we can keep
        stringValue = [[textField stringValue] copy];
    });
    [stringValue autorelease];
    // use stringValue in the background now
     
     */

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addView{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
    self.imageView.image = [UIImage imageNamed:@"bg_dw_lolapp"];
    [self.view addSubview:self.imageView];
    
    self.queryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.queryBtn.frame = CGRectMake(80, 320, 160, 30);
    [self.queryBtn setTitle:@"Download" forState:UIControlStateNormal];
    [self.queryBtn addTarget:self action:@selector(downLoad:) forControlEvents:UIControlEventTouchUpInside];
    self.queryBtn.tag = 1001;
    [self.view addSubview:self.queryBtn];
    
    self.queryBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.queryBtn1.frame = CGRectMake(80, 350, 160, 30);
    [self.queryBtn1 setTitle:@"Download" forState:UIControlStateNormal];
    [self.queryBtn1 addTarget:self action:@selector(downLoad:) forControlEvents:UIControlEventTouchUpInside];
    self.queryBtn1.tag = 1002;
    [self.view addSubview:self.queryBtn1];
}

- (void)downLoad:(id)sender{
    UIButton *btn = sender;
    
    switch (btn.tag) {
        case 1001:
        {
            //dispatch_async开启一个异步操作，第一个参数是指定一个gcd队列，第二个参数是分配一个处理事物的程序块到该队列。
            //dispatch_get_global_queue(0, 0)，指用了全局队列。
            //获取一个全局队列是接受两个参数，第一个是我分配的事物处理程序块队列优先级。分高低和默认，0为默认2为高，-2为低
            //#define DISPATCH_QUEUE_PRIORITY_HIGH     2
            //#define DISPATCH_QUEUE_PRIORITY_DEFAULT  0
            //#define DISPATCH_QUEUE_PRIORITY_LOW     (-2)
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURL *url = [NSURL URLWithString:@"http://img.lolbox.duowan.com/champions/Ashe_120x120.jpg"];
                NSData *data = [[NSData alloc] initWithContentsOfURL:url];
                UIImage *image = [[UIImage alloc] initWithData:data];
                if (data != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.imageView.image = image;
                    });
                }
                
            });
        }
            break;
        case 1002:
        {
            NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downLoadImage:) object:@"http://img.lolbox.duowan.com/champions/Garen_120x120.jpg"];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [queue addOperation:operation];
        }
            break;
            
        default:
            break;
    }
}

- (void)downLoadImage:(NSString *)url{
    NSURL *nsUrl = [NSURL URLWithString:url];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:nsUrl];
    UIImage *image = [[UIImage alloc] initWithData:data];
    [self performSelectorOnMainThread:@selector(refreshImageView:) withObject:image waitUntilDone:YES];
}

- (void)refreshImageView:(UIImage *)image{
    self.imageView.image = image;
}

/*
 
 
 self.queryBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
 self.queryBtn2.frame = CGRectMake(80, 380, 160, 30);
 [self.queryBtn2 setTitle:@"Download" forState:UIControlStateNormal];
 [self.queryBtn2 addTarget:self action:@selector(downLoad:) forControlEvents:UIControlEventTouchUpInside];
 self.queryBtn2.tag = 1003;
 [self.view addSubview:self.queryBtn2];
 
 self.queryBtn3 = [UIButton buttonWithType:UIButtonTypeSystem];
 self.queryBtn3.frame = CGRectMake(80, 410, 160, 30);
 [self.queryBtn3 setTitle:@"Download" forState:UIControlStateNormal];
 [self.queryBtn3 addTarget:self action:@selector(downLoad:) forControlEvents:UIControlEventTouchUpInside];
 self.queryBtn3.tag = 1004;
 [self.view addSubview:self.queryBtn3];
 
 self.queryBtn4 = [UIButton buttonWithType:UIButtonTypeSystem];
 self.queryBtn4.frame = CGRectMake(80, 450, 160, 30);
 [self.queryBtn4 setTitle:@"Download" forState:UIControlStateNormal];
 [self.queryBtn4 addTarget:self action:@selector(downLoad:) forControlEvents:UIControlEventTouchUpInside];
 self.queryBtn4.tag = 1005;
 [self.view addSubview:self.queryBtn4];
 
 case 1003:
 {
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 NSURL *url = [NSURL URLWithString:@"http://img.lolbox.duowan.com/champions/Ashe_120x120.jpg"];
 NSData *data = [[NSData alloc] initWithContentsOfURL:url];
 UIImage *image = [[UIImage alloc] initWithData:data];
 if (data != nil) {
 dispatch_async(dispatch_get_main_queue(), ^{
 self.imageView.image = image;
 });
 }
 
 });
 }
 break;
 case 1004:
 {
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 NSURL *url = [NSURL URLWithString:@"http://img.lolbox.duowan.com/champions/Garen_120x120.jpg"];
 NSData *data = [[NSData alloc] initWithContentsOfURL:url];
 UIImage *image = [[UIImage alloc] initWithData:data];
 if (data != nil) {
 dispatch_async(dispatch_get_main_queue(), ^{
 self.imageView.image = image;
 });
 }
 
 });
 }
 break;
 case 1005:
 {
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 NSURL *url = [NSURL URLWithString:@"http://img.lolbox.duowan.com/champions/Ashe_120x120.jpg"];
 NSData *data = [[NSData alloc] initWithContentsOfURL:url];
 UIImage *image = [[UIImage alloc] initWithData:data];
 if (data != nil) {
 dispatch_async(dispatch_get_main_queue(), ^{
 self.imageView.image = image;
 });
 }
 
 });
 }
 break;
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
