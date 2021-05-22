//
//  IWPopupView.m
//  IWExtendUI
//
//  Created by 秦传龙 on 2021/5/22.
//

#import "IWPopupView.h"
#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>
#import "IWPopupCollectionCell.h"


#define PX2REM(x) SCREEN_WIDTH / 375.f * x
#define SELF_HEIGHT PX2REM(308)

static  NSString * const collectionCellId = @"COllectionID";

@implementation IWPopupDataItem
@end

@interface PopViewWindow : UIWindow
@end

@implementation PopViewWindow


- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.userInteractionEnabled = YES;
        self.windowLevel = UIWindowLevelAlert;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.windowLevel = UIWindowLevelAlert;
    }
    return self;
}

@end



@interface IWPopupView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, QMUITextFieldDelegate>

@property (nonatomic, strong) PopViewWindow *window;
@property (nonatomic, strong) UIView        *contentView;
@property (nonatomic, strong) QMUIButton    *commitButton;
@property (nonatomic, strong) QMUILabel     *titleLabel;
@property (nonatomic, strong) QMUITextField *textFiled;
@property (nonatomic, strong) UICollectionView   *collectionView;
@property (nonatomic, strong) IWPopupDataItem *dataItem;

@end

@implementation IWPopupView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self setupUI];
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = touches.allObjects.lastObject;
    CGPoint point = [touch locationInView:self.view];
    if (!CGRectContainsPoint(self.contentView.frame, point)) {
        [self close];
    }
}

- (void)setupUI {
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = PX2REM(8);
    self.contentView.layer.masksToBounds = YES;
    self.contentView.transform = CGAffineTransformMakeTranslation(0, SELF_HEIGHT + PX2REM(10));
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(PX2REM(10));
        make.right.mas_equalTo(PX2REM(-10));
        make.bottom.mas_equalTo(PX2REM(-10));
        make.height.mas_equalTo(SELF_HEIGHT);
    }];
    
    [self.contentView addSubview:self.commitButton];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(PX2REM(20));
        make.right.bottom.mas_equalTo(PX2REM(-20));
        make.height.mas_equalTo(PX2REM(50));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(PX2REM(20));
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(PX2REM(24));
    }];
    
    [self.contentView addSubview:self.textFiled];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.commitButton.mas_top).offset(PX2REM(-20));
        make.left.right.mas_equalTo(self.commitButton);
        make.height.mas_equalTo(PX2REM(36));
    }];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(PX2REM(14));
        make.bottom.mas_equalTo(self.textFiled.mas_top).offset(PX2REM(-8));
    }];
}


- (void)show {
    if (!self.window) {
        self.window = [[PopViewWindow alloc] init];
        self.window.rootViewController = self;
        [self.window makeKeyAndVisible];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}

- (void)close {
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, SELF_HEIGHT + PX2REM(10));
    } completion:^(BOOL finished) {
        if (finished) {
            self.window.rootViewController = nil;
            [self.window resignKeyWindow];
        }
    }];
}


- (QMUILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[QMUILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:PX2REM(17) weight:UIFontWeightSemibold];
        _titleLabel.text = @"电池问题";
        _titleLabel.textColor = [UIColor qmui_colorWithHexString:@"#1F2329"];
    }
    return _titleLabel;
}

- (QMUITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [[QMUITextField alloc] init];
        _textFiled.backgroundColor = [UIColor qmui_colorWithHexString:@"#F8F9FA"];
        _textFiled.layer.borderColor = [UIColor qmui_colorWithHexString:@"#DEE0E3"].CGColor;
        _textFiled.layer.borderWidth = 1;
        _textFiled.placeholderColor = [UIColor qmui_colorWithHexString:@"#8F959E"];
        _textFiled.font = [UIFont systemFontOfSize:PX2REM(12)];
        _textFiled.placeholder = @"其他问题...";
        _textFiled.textInsets = UIEdgeInsetsMake(5, PX2REM(11), 5, PX2REM(11));
        _textFiled.layer.cornerRadius = PX2REM(4);
        _textFiled.textColor = [UIColor qmui_colorWithHexString:@"#1F2329"];
        _textFiled.enabled = YES;
        _textFiled.delegate = self;
    }
    return _textFiled;
}

- (QMUIButton *)commitButton {
    if (!_commitButton) {
        _commitButton = [[QMUIButton alloc] init];
        _commitButton.layer.cornerRadius = PX2REM(8);
        __weak typeof(self) weakSelf = self;
        [_commitButton setQmui_tapBlock:^(__kindof UIControl *sender) {
            if (weakSelf.commitCallback) {
                if (weakSelf.textFiled.text.length > 0) {
                    weakSelf.commitCallback(nil, weakSelf.textFiled.text);
                } else {
                    weakSelf.commitCallback(weakSelf.dataItem, nil);
                }
            }
            [weakSelf close];
        }];
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton setBackgroundColor:[UIColor qmui_colorWithHexString:@"#46BF82"]];
    }
    return _commitButton;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(PX2REM(150), PX2REM(36));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[IWPopupCollectionCell class] forCellWithReuseIdentifier:collectionCellId];
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.dataItem = self.data[indexPath.row];
    self.textFiled.text = @"";
    [collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IWPopupCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    IWPopupDataItem *dataItem = self.data[indexPath.row];
    cell.isSection = [dataItem.id isEqualToString: self.dataItem.id];
    cell.dataItem = dataItem;
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return  UIEdgeInsetsMake(PX2REM(16), PX2REM(20), 0, PX2REM(20));
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.text.length > 0) {
        self.dataItem = nil;
        [self.collectionView reloadData];
    }
}


@end
