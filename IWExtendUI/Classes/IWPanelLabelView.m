//
//  IWPanelLabelView.m
//  IWExtendUI
//
//  Created by 秦传龙 on 2021/5/21.
//

#import "IWPanelLabelView.h"
#import <Masonry/Masonry.h>

#define PX2REM(x) SCREEN_WIDTH / 375.f * x

@interface IWPanelLabelView ()


@end

@implementation IWPanelLabelView

- (instancetype)init{
    self = [super init];
    if (self) {
        //        [self setUpViews];
    }
    return self;
}
- (QMUILabel *)workHourLabel{
    if (_workHourLabel==nil) {
        _workHourLabel=[[QMUILabel alloc]init];
        _workHourLabel.font=[UIFont systemFontOfSize:PX2REM(14) weight:(UIFontWeightBold)];
        _workHourLabel.textColor=UIColor.whiteColor;
        }
    return _workHourLabel;
}
- (QMUILabel *)timeLabel{
    if (_timeLabel==nil) {
        _timeLabel=[[QMUILabel alloc]init];
        _timeLabel.font=[UIFont systemFontOfSize:PX2REM(9) weight:(UIFontWeightBold)];
        _timeLabel.textColor=UIColor.whiteColor;
    }
    return _timeLabel;
}
- (void)setUpViews:(BOOL)isworker {
    self.backgroundColor=UIColorMakeWithRGBA(255, 255, 255, 0.19);
    UILabel * titleLabel=[[UILabel alloc]init];
    
    titleLabel.font=[UIFont systemFontOfSize:PX2REM(7)];
    titleLabel.textColor=UIColorMakeWithRGBA(255, 255, 255, 0.38);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(PX2REM(8));
        make.left.mas_equalTo(PX2REM(20));
        make.height.mas_equalTo(PX2REM(11));
    }];
    
    [self addSubview:self.workHourLabel];
    [self.workHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(titleLabel);
        make.top.mas_equalTo(titleLabel.mas_bottom);
    }];
    
    UIView * intervalView=[[UIView alloc]init];
    intervalView.backgroundColor=UIColorMakeWithRGBA(255, 255, 255, 0.38);
    [self addSubview:intervalView];
    [intervalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(PX2REM(11));
        make.bottom.mas_equalTo(self).mas_offset(-PX2REM(11));
        make.left.mas_equalTo(self.workHourLabel.mas_right).mas_offset(PX2REM(12));
    }];
    
    
    UILabel * titleLabel2=[[UILabel alloc]init];
    titleLabel2.font=[UIFont systemFontOfSize:PX2REM(7)];
    titleLabel2.textColor=UIColorMakeWithRGBA(255, 255, 255, 0.38);
    [self addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_top);
        make.right.mas_equalTo(self).mas_offset(-PX2REM(49));
        make.height.mas_equalTo(titleLabel.mas_height);
    }];
    
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.workHourLabel.mas_bottom);
        make.centerX.mas_equalTo(titleLabel2);
    }];
    
    if (isworker) {
        titleLabel.text = @"工作时长";
        titleLabel2.text=@"更新时间";
    } else {
        titleLabel.text = @"套餐剩余天数";
        titleLabel2.text=@"套餐有效期";
    }
    
}

@end
