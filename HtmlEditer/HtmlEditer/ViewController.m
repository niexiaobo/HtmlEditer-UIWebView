//
//  ViewController.m
//  HtmlEditer
//
//  Created by niexiaobo on 2018/5/4.
//  Copyright © 2018年 NXB. All rights reserved.
//

#import "ViewController.h"
#import "WGCommon.h"
#import "CreateHtmlViewController.h"
#import "EditHtmlViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"文章编辑器";
    //add subViews
    [self addItemWithOrgY:150.0 title:@"1 创建文章     >" tag:0];
    [self addItemWithOrgY:250.0 title:@"2 编辑文章     >" tag:1];
}

//Push next view
- (void)pushDetail:(UIButton *)sender {
    if (sender.tag == 0) {
        CreateHtmlViewController *VC = [[CreateHtmlViewController alloc]init];
        VC.title = @"创建文章";
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        EditHtmlViewController *VC = [[EditHtmlViewController alloc]init];
        VC.title = @"编辑文章";
        VC.loadHtmlTitle = @"插画家邹俊晟";//文章标题
        VC.loadHtmlString = [self loadHtmlString];//文章:编辑的html内容
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (NSString *)loadHtmlString {
    return @"<p><br></p><p>邹俊晟（Page Tsou）是来自台湾的插画家，他以冷冽、现代、低彩度以及细腻的笔调被大众所认知.不仅如此，在众多的中国插画家中，Page可以算是其中的佼佼者，他不仅三次获得意大利波隆纳国际插画大奖（Bologna Children's Bookfair, Italy），还获得过美国3 ×3 国际当代插画大奖（3 x 3 Professional Show）首奖，并且还是CUCCI唯一指名合作的台湾艺术家。Page的画强调结构、秩序与骨骼建造，也擅长去营造超现实的视觉体验，冷冷清清却又蕴含着一种平凡的生活气息，两种截然不同的气质却又如此和谐的糅合在画面中，这或许就是我们的生活，一点苦，一点甜，混合在一起就成为了不透明的灰。</p><p><img src=\"http://rs.artree.net.cn/assets/rich/2018/05/02/0d81d238-fa11-49ef-aa70-39bfd9d0d0c0.jpeg\" data-filename=\"微信图片20180502165517.jpg\" style=\"width: 100%;\"></p><p>  《Chip  Fishes》</p><p><br></p><p></p><p><b>换一种方式诉说</b></p><p><b><br></b></p><p></p><p>Page在台湾一个半工业半农村的地方长大，大学毕业后，随了父母的心愿，拥有一份稳定工作，做了美术教师，因为无法安于现状，选择出国深造。“刚赴英国伦敦学习时，我英文很差无法表达，几乎没有朋友，也一直得不到老师的认可，常常心情很沉闷，我需要寻找一个释放的空间”。他尝试着转换一个角度，把这种受语言压抑、文化隔阂、都市冷漠，所压缩到极点的高压力，爆发成为一本以英式薯条为主角的绘本。</p>";
}

//UI
- (void)addItemWithOrgY:(CGFloat)OrgY title:(NSString *)title tag:(NSInteger)tag {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, OrgY, SCREEN_WIDTH, 70)];
    [btn setTitle:title forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    btn.tag = tag;
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(pushDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}
@end
