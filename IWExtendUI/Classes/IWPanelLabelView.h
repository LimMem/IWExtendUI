//
//  IWPanelLabelView.h
//  IWExtendUI
//
//  Created by 秦传龙 on 2021/5/21.
//

#import <UIKit/UIKit.h>
#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IWPanelLabelView : UIView


@property(nonatomic,strong) QMUILabel * workHourLabel;
@property(nonatomic,strong) QMUILabel * timeLabel;
///加载子view
- (void)setUpViews:(BOOL)isworker;
@end

NS_ASSUME_NONNULL_END
