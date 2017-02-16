//
//  UIButton+inits.h
//  BaseController
//
//  Created by wupeng on 2017/2/15.
//  Copyright (c) 2017年 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    BUTTON_NORMAL,
    BUTTON_RED,
    
} EButtonType;

@interface UIButton (inits)

/**
 *  创建button
 *
 *  @param frame    frame值
 *  @param type     类型
 *  @param title    标题
 *  @param tag      标签
 *  @param target   目标
 *  @param selector 执行句柄
 *
 *  @return 创建好的button
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                         buttonType:(EButtonType)type
                              title:(NSString *)title
                                tag:(NSInteger)tag
                             target:(id)target
                             action:(SEL)selector;

@end
