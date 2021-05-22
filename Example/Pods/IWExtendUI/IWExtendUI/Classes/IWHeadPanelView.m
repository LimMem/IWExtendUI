//
//  IWHeadPanelView.m
//  Masonry
//
//  Created by 秦传龙 on 2021/5/21.
//

#import "IWHeadPanelView.h"
#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>
#import "IWPanelLabelView.h"
#import "IWShareBundle.h"
#import "IWProgressPanel.h"

#define PX2REM(x) SCREEN_WIDTH / 375.f * x
#define SELF_HEIGHT PX2REM(180)

@implementation IWHeadPanelModal


@end


@interface IWHeadPanelView ()

@property (nonatomic, strong) QMUIButton *extendButton;
@property (nonatomic, strong) QMUIButton *flexButton;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) IWPanelLabelView *topViewChildView;/// 工作时长的view
@property (nonatomic, strong) IWPanelLabelView *topViewChildView2;/// 套餐的view
@property (nonatomic, strong) QMUIButton *reportedButton;/// 点击上报的button
@property (nonatomic, strong) QMUIButton *payButton ;/// 立即续费
@property (nonatomic, strong) IWProgressPanel *progressPanel; // 进度面板
@property (nonatomic, strong) UIBezierPath *bezierPath;

@end


@implementation IWHeadPanelView

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)supView
{
    frame.size.height = SELF_HEIGHT;
    
    self = [super initWithFrame:frame];
    if (self) {
        self.transform = CGAffineTransformMakeTranslation(0, -SELF_HEIGHT);
        [self initialzeView];
        [self createFlexButton:supView top:PX2REM(7) + frame.origin.y];
        [self setUpTopView];
        [supView addSubview:self];
        self.hidden = YES;
        [self bindEvent];
        
    }
    return self;
}

- (void)reloadData:(IWHeadPanelModal *)panelModal {
    self.topViewChildView.workHourLabel.text = panelModal.wokerTime;
    self.topViewChildView.timeLabel.text = panelModal.updateTime;
    self.topViewChildView2.workHourLabel.text = panelModal.remainDay;
    self.topViewChildView2.timeLabel.text = panelModal.expiryDate;
    [self.progressPanel setProgress:panelModal.electricity];
    
}

- (void)bindEvent {
    __weak typeof(self) weakSelf = self;
    [self.reportedButton setQmui_tapBlock:^(__kindof UIControl *sender) {
        if (weakSelf.reportCallback) {
            weakSelf.reportCallback();
        }
    }];
    [self.payButton setQmui_tapBlock:^(__kindof UIControl *sender) {
        if (weakSelf.payBtnCallback) {
            weakSelf.payBtnCallback();
        }
    }];
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
    [self addGestureRecognizer:gestureRecognizer];
}

- (void)gestureRecognizer:(UISwipeGestureRecognizer *)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        [self close];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.bezierPath) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.backgroundView.bounds cornerRadius:PX2REM(12)];
        UIBezierPath *cornerBezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.backgroundView.qmui_width - PX2REM(131), -PX2REM(9), PX2REM(120), PX2REM(120)) cornerRadius:PX2REM(60)];
        [bezierPath appendPath:cornerBezierPath];
        self.bezierPath = bezierPath;
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.backgroundView.bounds;
        shapeLayer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0].CGColor;
        shapeLayer.shadowOffset = CGSizeMake(0,0);
        shapeLayer.shadowOpacity = 1;
        shapeLayer.shadowRadius = PX2REM(3);
        shapeLayer.path = bezierPath.CGPath;
        shapeLayer.fillColor = [UIColor colorWithRed:113.f/255 green:113.f/255 blue:113.f/255 alpha:0.7].CGColor;
        [self.backgroundView.layer insertSublayer:shapeLayer atIndex:0];
    }

}


- (void)initialzeView {
    self.backgroundView = [[UIView alloc] init];
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(PX2REM(16));
        make.bottom.mas_equalTo(PX2REM(-7));
        make.left.mas_equalTo(PX2REM(12));
        make.right.mas_equalTo(PX2REM(-12));
    }];
    
    self.extendButton = [[QMUIButton alloc] init];
    [self.extendButton setTitle:@"收起" forState:UIControlStateNormal];
    [self.extendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.extendButton.titleLabel.font = [UIFont systemFontOfSize:PX2REM(9) weight:UIFontWeightMedium];
    [self.extendButton setImage:[UIImage iwShare_imageNamed:@"arrow-top"] forState:UIControlStateNormal];
    self.extendButton.spacingBetweenImageAndTitle = PX2REM(3);
    self.extendButton.imagePosition = QMUIButtonImagePositionRight;
    self.extendButton.imageEdgeInsets = UIEdgeInsetsMake(PX2REM(0), PX2REM(-2), PX2REM(-1), PX2REM(-2));
    self.extendButton.layer.cornerRadius = PX2REM(7);
    [self.extendButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    self.extendButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];;
    [self addSubview:self.extendButton];
    self.extendButton.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor;
    self.extendButton.layer.shadowOffset = CGSizeMake(0,0);
    self.extendButton.layer.shadowOpacity = 1;
    self.extendButton.layer.shadowRadius = PX2REM(5);
    [self.extendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(PX2REM(46));
        make.height.mas_equalTo(PX2REM(14));
    }];
   
    self.payButton = [[QMUIButton alloc] init];
    [self.payButton setTitle:@"立即续费" forState:UIControlStateNormal];
    [self.payButton setTitleColor:[UIColor colorWithRed:70/255.0 green:191/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.payButton.titleLabel.font = [UIFont systemFontOfSize:PX2REM(9) weight:UIFontWeightMedium];
    self.payButton.layer.cornerRadius = PX2REM(17 / 2.f);
    [self.payButton addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    self.payButton.backgroundColor = [UIColor colorWithRed:70/255.0 green:191/255.0 blue:130/255.0 alpha:0.14];
    self.payButton.layer.cornerRadius = PX2REM(13.5);
    self.payButton.layer.borderWidth = 1;
    self.payButton.layer.borderColor = [UIColor qmui_colorWithHexString:@"#46BF82"].CGColor;
    [self.backgroundView addSubview:self.payButton];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(PX2REM(-16));
        make.right.mas_equalTo(PX2REM(-33));
        make.width.mas_equalTo(PX2REM(80));
        make.height.mas_equalTo(PX2REM(27));
    }];
    
    self.progressPanel = [[IWProgressPanel alloc] initWithFrame:CGRectMake(self.qmui_width + PX2REM(-10) - PX2REM(146), PX2REM(10), PX2REM(146), PX2REM(146))];
    [self addSubview:self.progressPanel];
}

- (void)createFlexButton:(UIView *)superView top:(CGFloat)top {
    self.flexButton = [[QMUIButton alloc] init];
    [self.flexButton setTitle:@"展开电池挂件" forState:UIControlStateNormal];
    [self.flexButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.flexButton.titleLabel.font = [UIFont systemFontOfSize:PX2REM(9) weight:UIFontWeightMedium];
    [self.flexButton setImage:[UIImage iwShare_imageNamed:@"arrow-bottom"] forState:UIControlStateNormal];
    self.flexButton.spacingBetweenImageAndTitle = PX2REM(3);
    self.flexButton.imagePosition = QMUIButtonImagePositionRight;
    self.flexButton.imageEdgeInsets = UIEdgeInsetsMake(PX2REM(0), PX2REM(-2), PX2REM(-1), PX2REM(-2));
    self.flexButton.layer.cornerRadius = PX2REM(17 / 2.f);
    [self.flexButton addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
    self.flexButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];;
    [superView addSubview:self.flexButton];
    [self.flexButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(PX2REM(95));
        make.height.mas_equalTo(PX2REM(17));
    }];
}


- (void)open {
    self.flexButton.hidden = YES;
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self->_isOpen = NO;
    }];
}

- (void)close {
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -SELF_HEIGHT);
    } completion:^(BOOL finished) {
        self->_isOpen = YES;
        self.hidden = YES;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.flexButton.hidden = NO;
    });
}

///拼接展示的view
- (void)setUpTopView{
    ///拼接工作时长的view
    [self.backgroundView addSubview:self.topViewChildView];
    [self.topViewChildView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(PX2REM(28));
        make.left.mas_equalTo(PX2REM(12));
        make.width.mas_equalTo(SCREEN_WIDTH * 0.512);
        make.height.mas_equalTo(PX2REM(43));
    }];
    [self.topViewChildView setUpViews:YES];
  
    [self.backgroundView addSubview:self.topViewChildView2];
    [self.topViewChildView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topViewChildView.mas_left);
        make.width.mas_equalTo(self.topViewChildView.mas_width);
        make.height.mas_equalTo(self.topViewChildView.mas_height);
        make.bottom.mas_equalTo(self.backgroundView).mas_offset(-PX2REM(17));
    }];
    [self.topViewChildView2 setUpViews:NO];
    
    [self.backgroundView addSubview:self.reportedButton];
    [self.reportedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topViewChildView.mas_left);
        make.top.mas_equalTo(self.topViewChildView.mas_bottom).mas_offset(PX2REM(5));
    }];
    
}


- (IWPanelLabelView *)topViewChildView{
    if (!_topViewChildView) {
        _topViewChildView=[[IWPanelLabelView alloc]init];
        _topViewChildView.backgroundColor=UIColorMakeWithRGBA(57, 57, 57, 1);
        _topViewChildView.layer.cornerRadius=PX2REM(43)/2;
    }
    return _topViewChildView;
}
- (IWPanelLabelView *)topViewChildView2{
    if (!_topViewChildView2) {
        _topViewChildView2=[[IWPanelLabelView alloc]init];
        _topViewChildView2.backgroundColor=UIColorMakeWithRGBA(57, 57, 57, 1);
        _topViewChildView2.layer.cornerRadius=PX2REM(43)/2;
    }
    return _topViewChildView2;
}

- (QMUIButton *)reportedButton{
    if (_reportedButton==nil) {
        _reportedButton=[[QMUIButton alloc]init];
        [_reportedButton setTitle:@"电池有问题？点击上报" forState:(UIControlStateNormal)];
        _reportedButton.titleLabel.font=[UIFont systemFontOfSize:9];
        [_reportedButton setTitleColor:UIColorMakeWithRGBA(70, 191, 130, 1) forState:(UIControlStateNormal)];
        
    }
    return _reportedButton;
}

@end
