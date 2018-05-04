//
//  BaseHtmlViewController.h
//  HtmlEditer
//
//  Created by niexiaobo on 2018/5/4.
//  Copyright © 2018年 NXB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseHtmlViewController : UIViewController

@property(nonatomic,strong)NSString *loadHtmlTitle;//文章标题
@property(nonatomic,strong)NSString *loadHtmlString;//文章内容
//加载初始化数据
- (NSString *)getHtmlDocumentString;
@end
