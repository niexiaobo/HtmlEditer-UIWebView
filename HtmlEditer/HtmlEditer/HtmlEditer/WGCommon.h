//
//  WGCommon.h
//  WGRichTextEditor
//
//  Created by 胡文广 on 2018/3/19.
//  Copyright © 2018年 wenguang. All rights reserved.
//

//#ifndef WGCommon_h
//#define WGCommon_h
//
//#endif /* WGCommon_h */
#define COLOR(r,g,b,a) ([UIColor colorWithRed:(float)r/255.f green:(float)g/255.f blue:(float)b/255.f alpha:a])

#import "UIWebView+KWWebViewJSTool.h"
#import "UIWebView+KWHideAccessoryView.h"
#import "KWEditorBar.h"
#import "KWFontStyleBar.h"

#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define IS_IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) ? 1 : 0) : 0)

#define SCREEN_Y (IS_IPhoneX ? 88 : 64)   //距离顶部导航高度
#define SCREEN_Top_Y (IS_IPhoneX ? 24 : 0) //距离顶部高度0
#define SCREEN_Bar_H (IS_IPhoneX ? 44 : 20) //状态栏高度
#define SCREEN_Nav_H (IS_IPhoneX ? 88 : 64) //导航高度
#define SCREEN_Nav_Content_H (IS_IPhoneX ? 44 : 44)
#define SCREEN_B_Y (IS_IPhoneX ? -83 : -49) //约束距离底部高度值
#define SCREEN_B_H (IS_IPhoneX ? 83 : 49) //底部高度
#define SCREEN_B_0 (IS_IPhoneX ? 34 : 0) ////距离底部
