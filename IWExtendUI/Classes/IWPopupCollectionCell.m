//
//  IWPopupCollectionCell.m
//  IWExtendUI
//
//  Created by 秦传龙 on 2021/5/22.
//

#import "IWPopupCollectionCell.h"
#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>
#import "IWPopupView.h"
#define PX2REM(x) SCREEN_WIDTH / 375.f * x

@implementation IWPopupCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:PX2REM(12)];
        self.titleLabel.textColor = [UIColor qmui_colorWithHexString:@"#1F2329"];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.layer.cornerRadius = PX2REM(4);
        self.titleLabel.layer.borderWidth = 1;
        self.titleLabel.layer.borderColor = [UIColor qmui_colorWithHexString:@"#DEE0E3"].CGColor;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        
    }
    return self;
}

- (void)setDataItem:(IWPopupDataItem *)dataItem {
    self.titleLabel.text = dataItem.label;
}

- (void)setIsSection:(BOOL)isSection {
    _isSection = isSection;
    if (isSection) {
        self.titleLabel.layer.borderColor = [UIColor qmui_colorWithHexString:@"#46BF82"].CGColor;
        self.titleLabel.textColor = [UIColor qmui_colorWithHexString:@"#46BF82"];
    } else {
        self.titleLabel.layer.borderColor = [UIColor qmui_colorWithHexString:@"#DEE0E3"].CGColor;
        self.titleLabel.textColor = [UIColor qmui_colorWithHexString:@"#1F2329"];
    }
}

@end
