//
//  QSCNewworkTipView.m
//  qingsongchou
//
//  Created by qsc on 16/8/31.
//  Copyright © 2016年 Chai. All rights reserved.
//

#define kBackgroundViewHeight 40
#define kTipLabelHeight 20
#define kTipLabelWidth 250

#import "QSCNewworkTipView.h"
#import "UIColor+Extension.h"

@interface QSCNewworkTipView ()
{
    UILabel *_tipLabel;
}
@end

@implementation QSCNewworkTipView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //设置背景色
        self.backgroundColor = [UIColor colorWithHexColorString:@"B9DEF9"];
        
        //提示label
        _tipLabel = [UILabel new];
        _tipLabel.bounds = CGRectMake(0, 0, kTipLabelWidth, kTipLabelHeight);
        _tipLabel.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [UIColor colorWithHexColorString:@"4E9CD9"];
        _tipLabel.text = @"没有网络连接，请稍后再试！";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    return self;
}

@end
