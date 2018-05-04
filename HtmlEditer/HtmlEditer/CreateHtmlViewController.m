//
//  CreateHtmlViewController.m
//  HtmlEditer
//
//  Created by niexiaobo on 2018/5/4.
//  Copyright © 2018年 NXB. All rights reserved.
//

#import "CreateHtmlViewController.h"

@interface CreateHtmlViewController ()

@end

@implementation CreateHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//加载本地页面
- (NSString *)getHtmlDocumentString {
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"articleInitFile"                                                              ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    return htmlCont;
}

//提交后台请求...
- (void)requestMsg {
    NSLog(@"标题:%@",self.loadHtmlTitle);
    NSLog(@"内容(标签格式):%@",self.loadHtmlString);
    
}
@end
