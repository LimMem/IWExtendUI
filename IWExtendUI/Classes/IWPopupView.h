//
//  IWPopupView.h
//  IWExtendUI
//
//  Created by 秦传龙 on 2021/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IWPopupDataItem: NSObject

@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *id;

@end

@interface IWPopupView : UIViewController

/// 提交 当输入文字时自动取消选中，
@property (nonatomic, copy) void (^commitCallback)(IWPopupDataItem *item, NSString *otherDes);

@property (nonatomic, copy) NSArray<IWPopupDataItem *> *data;

- (void)show;

- (void)close;

@end

NS_ASSUME_NONNULL_END
