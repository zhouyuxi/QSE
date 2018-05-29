//
//  ProgressHUD.m
//  qingsongchou
//
//  Created by qsc on 16/8/30.
//  Copyright © 2016年 Chai. All rights reserved.
//

#define kLeftMargin 15
#define kTotalWidth 225
#define kTopMargin 13
#define kLineSpacing 7

#import "ProgressHUD.h"
#import "UIColor+Extension.h"

@interface ProgressHUD ()
{
    UIView *_backgroundView;
    UILabel *_tipLabel;
}
@end

@implementation ProgressHUD

singleton_implementation(ProgressHUD)

+ (void)showError:(NSString *)errorMsg Interaction:(BOOL)interaction{
    [[ProgressHUD sharedProgressHUD] showSucessStr:errorMsg];
}
+ (void)showSuccess:(NSString *)successMsg Interaction:(BOOL)interaction{
    [[ProgressHUD sharedProgressHUD] showSucessStr:successMsg];
}
+ (void)showSuccess:(NSString *)msg{
    [[ProgressHUD sharedProgressHUD] showSucessStr:msg];
}
+ (void)showError:(NSString *)msg{
    [[ProgressHUD sharedProgressHUD] showSucessStr:msg];
}

- (void)showSucessStr:(NSString *)tipStr {
    
    if (tipStr.length <= 0) return;
    if (_backgroundView) return;
    if (_tipLabel) return;
    
    //计算宽度
    CGRect fitRect = [self calculateWidthWithText:tipStr Font:15 lines:1 lineSpacing:0 fitWidth:0];
    CGFloat textWidth = fitRect.size.width;
    CGFloat totalWidth = textWidth + 2 * kLeftMargin;
    CGFloat totalHeight = 0.f;
    
    //根据宽度判断是否折行 NSMutableParagraphStyle
    CGFloat tipLableWidth = 0.f;
    CGFloat tipLabelHeight = 0.f;
    NSInteger lines = 1;
    CGFloat lineSpaceing = 0.f;
    if (totalWidth <= kTotalWidth) {
        
        tipLableWidth = textWidth;
        tipLabelHeight = fitRect.size.height;
        totalHeight = 40;
        
    }else {
        
        //计算高度
        totalWidth = kTotalWidth;
        lines = 0;
        lineSpaceing = kLineSpacing;
        CGRect MultipleRect = [self calculateWidthWithText:tipStr Font:15 lines:0 lineSpacing:kLineSpacing fitWidth:totalWidth - 2 * kLeftMargin];
        tipLableWidth = totalWidth - 2 * kLeftMargin;
        tipLabelHeight = MultipleRect.size.height;
        totalHeight = tipLabelHeight + 2 * kTopMargin;
    }
    
    //背景view
    _backgroundView = [[UIView alloc] init];
    _backgroundView.bounds = CGRectMake(0, 0, totalWidth, totalHeight);
    _backgroundView.center = CGPointMake(kDeviceWidth / 2, KDeviceHeight / 2);
    _backgroundView.backgroundColor = [UIColor colorWithHexColorString:@"000000" alpha:0.6];
    [_backgroundView.layer setCornerRadius:5.f];
    [_backgroundView.layer setMasksToBounds:YES];
    [WINDOW addSubview:_backgroundView];
    
    //设置文字属性
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpaceing;
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:tipStr
                                                                                 attributes:@{NSParagraphStyleAttributeName : style}];
    //设置文字label
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.bounds = CGRectMake(0, 0, tipLableWidth, tipLabelHeight);
    _tipLabel.center = CGPointMake(_backgroundView.bounds.size.width / 2, _backgroundView.bounds.size.height / 2);
    _tipLabel.font = [UIFont systemFontOfSize:15];
    _tipLabel.numberOfLines = lines;
    _tipLabel.textColor = [UIColor whiteColor];
    _tipLabel.alpha = 0.f;
    [_tipLabel setAttributedText:attriStr];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    [_backgroundView addSubview:_tipLabel];
    
    //动画
    [self showAnimation];
}

- (void)showAnimation {
    
    _backgroundView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        
        _backgroundView.hidden = NO;
        _tipLabel.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        //关闭弹框
        [self dissHUD];
    }];
}

- (void)dissHUD {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1.2 animations:^{
            
            _tipLabel.alpha = 0.f;
            _tipLabel = nil;
            [_tipLabel removeFromSuperview];
            
            _backgroundView.hidden = YES;
            _backgroundView = nil;
            [_backgroundView removeFromSuperview];
        }];
    });
}

#pragma mark --- 计算文字宽度
- (CGRect)calculateWidthWithText:(NSString *)tipStr Font:(CGFloat)font lines:(NSInteger)lines lineSpacing:(CGFloat)lineSpaceing fitWidth:(CGFloat)fitWidth {
    
    //基本设置
    UILabel *fitLabel = [UILabel new];
    fitLabel.size = CGSizeMake(fitWidth, MAXFLOAT);
    fitLabel.font = [UIFont systemFontOfSize:font];
    fitLabel.numberOfLines = lines;
    
    //计算宽度
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpaceing;
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:tipStr
                                                                                 attributes:@{NSParagraphStyleAttributeName : style}];
    [fitLabel setAttributedText:attriStr];
    [fitLabel sizeToFit];
    
    return fitLabel.frame;
}

@end

