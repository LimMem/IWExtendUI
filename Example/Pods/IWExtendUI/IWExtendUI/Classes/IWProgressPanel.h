//
//  IWProgressPanel.h
//  IWExtendUI
//
//  Created by 秦传龙 on 2021/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IWProgressPanel : UIView

- (void)drawView;

- (void)setProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
