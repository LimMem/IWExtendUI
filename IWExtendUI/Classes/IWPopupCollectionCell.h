//
//  IWPopupCollectionCell.h
//  IWExtendUI
//
//  Created by 秦传龙 on 2021/5/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class IWPopupDataItem;
@interface IWPopupCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL isSection;
@property (nonatomic, strong) IWPopupDataItem *dataItem;

@end

NS_ASSUME_NONNULL_END
