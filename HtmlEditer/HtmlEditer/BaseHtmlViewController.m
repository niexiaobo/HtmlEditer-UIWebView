//
//  BaseHtmlViewController.m
//  HtmlEditer
//
//  Created by niexiaobo on 2018/5/4.
//  Copyright © 2018年 NXB. All rights reserved.
//

#import "BaseHtmlViewController.h"
#import "CreateHtmlViewController.h"
#import "WGCommon.h"

@interface BaseHtmlViewController ()<UITextViewDelegate,UIWebViewDelegate,KWEditorBarDelegate,KWFontStyleBarDelegate>
//view & property
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,assign) BOOL isExitView;
@property (nonatomic,copy) NSString *tempArticleID;
@property (nonatomic,copy) NSString *tempTitle;
@property (nonatomic,copy) NSString *tempContent;
@property (nonatomic,assign) BOOL isLoadFinsh;
@property (nonatomic,strong) NSTimer *timer;
//bar
@property (nonatomic,strong) KWEditorBar *toolBarView;
@property (nonatomic,strong) KWFontStyleBar *fontBar;

@end

@implementation BaseHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //UI
    [self.view addSubview:self.webView];
    [self.view addSubview:self.toolBarView];
    //Notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    //rightBarButtonItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitHTML)];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = CGRectMake(0,SCREEN_Y, SCREEN_WIDTH,SCREEN_HEIGHT - KWEditorBar_Height - SCREEN_Y - SCREEN_B_0);
}

- (void)dealloc {
    @try {
        [self.toolBarView removeObserver:self forKeyPath:@"transform"];
    } @catch (NSException *exception)
    {
        NSLog(@"Exception: %@", exception);
    } @finally {
        // Added to show finally works as well
    }
    self.timer = nil;
}

- (void)isShowPlaceholder {
    if ([self.webView contentText].length <= 0) {
        [self.webView showContentPlaceholder];
    } else {
        [self.webView clearContentPlaceholder];
    }
}
#pragma mark - 编辑 & 创建
//插入图片
- (void)showPhotos {
    //1 打开图片选择器,在获取图片代理方法返回后操作
    
    //2 获取image后直接插入UIImage Data
    //[self.webView inserImage:<#(UIImage *)#> alt:<#(NSString *)#>];
    
    //3 插入image Url (获取image请求后台返回Url)
    [self.webView insertImageUrl:@"http://rs.artree.net.cn/assets/rich/2018/05/02/0d81d238-fa11-49ef-aa70-39bfd9d0d0c0.jpeg" alt:nil];
    
}

//获取编辑信息,并提交
- (void)submitHTML {
    self.loadHtmlTitle = [self.webView titleText];
    self.loadHtmlString = [self.webView contentHtmlText];
    
    //提交后台请求...
    [self requestMsg];
}
//提交后台请求...
- (void)requestMsg {
    
}
#pragma mark - 代理 Delegate

//editorbar Delegate
- (void)editorBar:(KWEditorBar *)editorBar didClickIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            if (self.toolBarView.transform.ty < 0) {
                [self.webView hiddenKeyboard];
            }else{
                [self.webView showKeyboardContent];
            }
            break;
        case 1:{
            [self.webView stringByEvaluatingJavaScriptFromString:@"document.execCommand('undo')"];
        }
            break;
        case 2:{
            [self.webView stringByEvaluatingJavaScriptFromString:@"document.execCommand('redo')"];
        }
            break;
        case 3:
            editorBar.fontButton.selected = !editorBar.fontButton.selected;
            if (editorBar.fontButton.selected) {
                [self.view addSubview:self.fontBar];
            }else{
                [self.fontBar removeFromSuperview];
            }
            break;
        case 4:{
            NSString *selectionStr = [self.webView getSelectString];
            if (selectionStr.length > 0) {
                if ([[self.webView getSelection] isEqualToString:@"A"]) {
                    [self.webView clearLink];
                }else{
                    //[self showLinkView:selectionStr];
                }
            } else {
                if (!self.toolBarView.keyboardButton.selected){
                    [self.webView showKeyboardContent];
                }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // [self showLinkView:nil];
                });
            }
        }break;
        case 5:{
            if (!self.toolBarView.keyboardButton.selected) {
                [self.webView showKeyboardContent];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showPhotos];
                });
            }else{
                [self showPhotos];
            }
        }
            break;
        default:
            break;
    }
    
}

//fontbar Delegate
- (void)fontBar:(KWFontStyleBar *)fontBar didClickBtn:(UIButton *)button{
    if (self.toolBarView.transform.ty>=0) {
        [self.webView showKeyboardContent];
    }
    
    switch (button.tag) {
        case 0:{
            [self.webView bold];
        }
            break;
        case 1:{
            [self.webView underline];
        }
            break;
        case 2:{
            [self.webView italic];
        }
            break;
        case 3:{
            //            [self.webView heading3];
            
            [self.webView setFontSize:@"2"];
        }
            break;
        case 4:{
            //            [self.webView heading2];
            [self.webView setFontSize:@"3"];
        }
            break;
        case 5:{
            //            [self.webView heading1];
            [self.webView setFontSize:@"4"];
        }
            break;
        case 6:{
            [self.webView justifyLeft];
        }
            break;
        case 7:{
            [self.webView justifyCenter];
        }
            break;
        case 8:{
            [self.webView justifyRight];
        }
            break;
        case 9:{
            [self.webView unorderlist];
        }
            break;
        case 10:{
            button.selected = !button.selected;
            
            if (button.selected) {
                
                [self.webView indent];
            }else{
                [self.webView outdent];
            }
        }
            break;
            
            
        case 11:{
            
        }
            break;
        default:
            break;
    }
    
}
- (void)fontBarResetNormalFontSize {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView normalFontSize];
    });
}

//webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //设置标题
    if (self.loadHtmlTitle.length > 0) {
        [self.webView setupTitle:self.loadHtmlTitle];
    }
    //是否显示占位符
    if (self.loadHtmlString.length > 0) {
        [self.webView clearContentPlaceholder];
    } else {
        [self.webView showContentPlaceholder];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"NSEerror = %@",error);
    if([error code] == NSURLErrorCancelled){
        return;
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    NSLog(@"loadURL = %@",urlString);
    
    [self handleEvent:urlString];
    
    if ([urlString rangeOfString:@"re-state-content://"].location != NSNotFound) {
        NSString *className = [urlString stringByReplacingOccurrencesOfString:@"re-state-content://" withString:@""];
        [self.fontBar updateFontBarWithButtonName:className];
        if ([self.webView contentText].length <= 0) {
            [self.webView showContentPlaceholder];
        }else{
            [self.webView clearContentPlaceholder];
        }
        if ([[className componentsSeparatedByString:@","] containsObject:@"unorderedList"]) {
            [self.webView clearContentPlaceholder];
        }
    }
    return YES;
}
#pragma mark - 键盘 监听
- (void)keyBoardWillChangeFrame:(NSNotification*)notification {
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (frame.origin.y == SCREEN_HEIGHT) {
        [UIView animateWithDuration:duration animations:^{
            self.toolBarView.transform =  CGAffineTransformIdentity;
            self.toolBarView.keyboardButton.selected = NO;
        }];
    }else{
        [UIView animateWithDuration:duration animations:^{
            self.toolBarView.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
            self.toolBarView.keyboardButton.selected = YES;
            
        }];
    }
}

- (void)keyBoardWillShow:(NSNotification*)notification {
    
}

- (void)keyBoardDidHide:(NSNotification*)notification {
    
}

- (void)hiddenToorBar:(BOOL)show {
    self.fontBar.hidden = show;
    self.toolBarView.hidden = show;
}

#pragma mark - toolBar 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"transform"]) {
        CGRect fontBarFrame = self.fontBar.frame;
        fontBarFrame.origin.y = CGRectGetMaxY(self.toolBarView.frame)- KWFontBar_Height - KWEditorBar_Height;
        self.fontBar.frame = fontBarFrame;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mar - webView监听
- (void)handleEvent:(NSString *)urlString {
    if ([urlString hasPrefix:@"re-state-content://"]) {
        [self hiddenToorBar:NO];
    } else if ([urlString hasPrefix:@"re-state-title://"]) {
        [self hiddenToorBar:YES];
    }
}

#pragma mark - Gets
- (KWEditorBar *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [KWEditorBar editorBar];
        _toolBarView.frame = CGRectMake(0,SCREEN_HEIGHT - KWEditorBar_Height, SCREEN_WIDTH, KWEditorBar_Height);
        _toolBarView.backgroundColor = COLOR(237, 237, 237, 1);
        _toolBarView.delegate = self;
        _toolBarView.hidden = YES;
        [_toolBarView addObserver:self forKeyPath:@"transform" options:
         NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return _toolBarView;
}

- (KWFontStyleBar *)fontBar {
    if (!_fontBar) {
        _fontBar = [[KWFontStyleBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.toolBarView.frame) - KWFontBar_Height - KWEditorBar_Height, self.view.frame.size.width, KWFontBar_Height)];
        _fontBar.delegate = self;
        _fontBar.hidden = YES;
        [_fontBar.heading2Item setSelected:YES];
        
    }
    return _fontBar;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        //设置内容
        [_webView loadHTMLString:[self getHtmlDocumentString] baseURL:baseURL];
        _webView.scrollView.bounces=NO;
        _webView.hidesInputAccessoryView = YES;
        
    }
    return _webView;
}

- (NSString *)getHtmlDocumentString {
    //sub 重载
    return @"";
}
@end
