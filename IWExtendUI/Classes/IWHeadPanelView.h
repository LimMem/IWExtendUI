//
//  IWHeadPanelView.h
//  Masonry
//
//  Created by 秦传龙 on 2021/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IWHeadPanelModal : NSObject

// 电池电量 0 ~ 1
@property (nonatomic, assign) CGFloat electricity;

// 工作时长
@property (nonatomic, copy) NSString *wokerTime;

// 更新时间
@property (nonatomic, copy) NSString *updateTime;
// 剩余天数
@property (nonatomic, copy) NSString *remainDay;

// 有效期
@property (nonatomic, copy) NSString *expiryDate;

@end


@interface IWHeadPanelView : UIView

// 是否已经展开
@property (nonatomic, assign, readonly) BOOL isOpen;

// 唯一初始化方法
- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)supView;

// 立即续费按钮回调
@property (nonatomic, copy) void (^payBtnCallback)(void);

/// 立即上报按钮回调
@property (nonatomic, copy) void (^reportCallback)(void);

- (void)reloadData:(IWHeadPanelModal *)panelModal;

- (void)close;

- (void)show;

@end

NS_ASSUME_NONNULL_END
