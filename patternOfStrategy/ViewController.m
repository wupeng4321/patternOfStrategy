//
//  AppDelegate.h
//  patternOfStrategy
//
//  Created by wupeng on 2017/2/15.
//  Copyright © 2017年 wupeng. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+inits.h"
#import "CustomField.h"
#import "UIView+SetRect.h"
#import "RegExCategories.h"
#import "UIInfomationView.h"

#import "EmailValidator.h"
#import "PhoneNumberValidator.h"

@interface ViewController () <UITextFieldDelegate>

//输入邮箱的验证框
@property (nonatomic, strong) CustomField  *emailField;

//输入电话号码的验证框
@property (nonatomic, strong) CustomField  *phoneNumberField;

/**
 验证email地址

 @param input input 验证输入
 @return 输出结果
 */
- (NSString *)validateEmailInput:(UITextField *)input;


/**
 验证电话号码

 @param input input 输入
 @return 输出结果
 */
- (NSString *)validatePhoneNumberInput:(UITextField *)input;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 初始化按钮
    [self initButton];
    
    // 初始化验证框
    [self initCustomFields];
}

#pragma mark - 初始化文本输入框
- (void)initCustomFields {
    
    
    self.emailField             = [[CustomField alloc] initWithFrame:CGRectMake(30, 80, Width - 60, 30)];
    self.emailField.placeholder = @"请输入邮箱";
    self.emailField.delegate    = self;
    self.emailField.validator   = [EmailValidator new];
    [self.view addSubview:self.emailField];
    
    
    self.phoneNumberField             = [[CustomField alloc] initWithFrame:CGRectMake(30, 80 + 40, Width - 60, 30)];
    self.phoneNumberField.placeholder = @"请输入电话号码";
    self.phoneNumberField.delegate    = self;
    self.phoneNumberField.validator   = [PhoneNumberValidator new];
    [self.view addSubview:self.phoneNumberField];
}

#pragma mark - 初始化按钮以及按钮事件
- (void)initButton {
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(30, 30, 90, 30)
                                            buttonType:0
                                                 title:@"Back"
                                                   tag:0
                                                target:self
                                                action:@selector(buttonsEvent:)];
    [self.view addSubview:button];
}

- (void)buttonsEvent:(UIButton *)button {
    
    [self.view endEditing:YES];
}

#pragma mark - 文本框代理
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    CustomField *customField = (CustomField *)textField;
    
    if ([customField validate] == NO) {
        
        [UIInfomationView showAlertViewWithTitle:nil
                                         message:customField.validator.errorMessage
                               cancelButtonTitle:nil
                               otherButtonTitles:@[@"确定"]
                                    clickAtIndex:^(NSInteger buttonIndex) {
                                        
                                    }];
    }
}
//相较于将这些判断逻辑现在现在vc里，明显使用这种策略模式会优雅简洁的多
#pragma mark - 验证算法
- (NSString *)validateEmailInput:(UITextField *)input {
    
    NSString *outString = nil;
    
    if (input.text.length <= 0) {
        
        outString = @"没有输入";
        
    } else {
        
        BOOL isMatch = [input.text isMatch:RX(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")];
        if (isMatch == NO) {
            
            outString = @"请输入正确的邮箱";
            
        } else {
            
            outString = nil;
        }
    }
    
    return outString;
}

- (NSString *)validatePhoneNumberInput:(UITextField *)input {
    
    NSString *outString = nil;
    
    if (input.text.length <= 0) {
        
        outString = @"没有输入";
        
    } else {
        
        BOOL isMatch = [input.text isMatch:RX(@"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$")];
        if (isMatch == NO) {
            
            outString = @"请输入正确的手机号码";
            
        } else {
            
            outString = nil;
        }
    }
    
    return outString;
}

@end
