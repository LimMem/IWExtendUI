//
//  IWProgressPanel.m
//  IWExtendUI
//
//  Created by 秦传龙 on 2021/5/21.
//

#import "IWProgressPanel.h"
#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>
#define PX2REM(x) SCREEN_WIDTH / 375.f * x

@interface IWProgressPanel ()

@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation IWProgressPanel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawView];
        [self setupView];
    }
    return self;
}


- (void)setupView {
    self.tipsLabel = [[QMUILabel alloc] init];
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    self.tipsLabel.textColor = [UIColor whiteColor];
    self.tipsLabel.font = [UIFont systemFontOfSize:PX2REM(12)];
    self.tipsLabel.text = @"电量";
    [self addSubview:self.tipsLabel];
    
    self.progressLabel = [[QMUILabel alloc] init];
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.textColor = [UIColor qmui_colorWithHexString:@"#46BF82"];
    self.progressLabel.font = [UIFont systemFontOfSize:PX2REM(26) weight:UIFontWeightBold];
    self.progressLabel.text = @"0%";
    [self addSubview:self.progressLabel];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(PX2REM(35));
        make.height.mas_equalTo(PX2REM(19));
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.tipsLabel.mas_bottom);
        make.height.mas_equalTo(PX2REM(27));
    }];
}


- (void)drawView {
    self.bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2.0f - PX2REM(4)) radius:CGRectGetWidth(self.frame) /  2 - PX2REM(15) startAngle:M_PI_4 * 3 endAngle:2 * M_PI + M_PI_4 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = self.bezierPath.CGPath;
    maskLayer.frame = self.bounds;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.lineWidth = PX2REM(16);
    maskLayer.strokeColor = [UIColor qmui_colorWithHexString:@"#555655"].CGColor;
    maskLayer.strokeStart = 0;
    maskLayer.strokeEnd = 1;
    [self.layer addSublayer:maskLayer];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = self.bezierPath.CGPath;
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = PX2REM(16);
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0;
    self.shapeLayer = shapeLayer;
    
    CAGradientLayer *gradientLayer =[[CAGradientLayer alloc]init];
    CGRect frame = self.bounds;
    gradientLayer.frame = frame;
    gradientLayer.colors = @[(id)[UIColor qmui_colorWithHexString:@"#46BF82"].CGColor, (id)[UIColor qmui_colorWithHexString:@"#7CE1E0"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    [self.layer addSublayer:gradientLayer];
    [self.layer addSublayer:shapeLayer];
    gradientLayer.mask = shapeLayer;
}

- (void)setProgress:(CGFloat)progress {
    self.shapeLayer.strokeEnd = progress;
    self.progressLabel.text = [NSString stringWithFormat:@"%d%%", (int)(progress * 100)];
}

@end
