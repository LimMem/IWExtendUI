//
//  IWViewController.m
//  IWExtendUI
//
//  Created by LimMem on 05/21/2021.
//  Copyright (c) 2021 LimMem. All rights reserved.
//

#import "IWViewController.h"
#import <IWExtendUI/IWHeadPanelView.h>
#import <IWExtendUI/IWPopupView.h>
#import <QMUIKit/QMUIKit.h>
#import <Masonry/Masonry.h>

#define PX2REM(x) SCREEN_WIDTH / 375.f * x
@interface IWViewController ()

@property (nonatomic, strong) QMUITextField *textFiled;

@end

@implementation IWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    IWHeadPanelView *panelView = [[IWHeadPanelView alloc] initWithFrame:CGRectMake(0, NavigationContentTop, CGRectGetWidth(self.view.frame), 0) superView:self.view];
    
    IWHeadPanelModal *modal = [[IWHeadPanelModal alloc] init];
    modal.electricity = 0.56;
    modal.wokerTime = @"34分钟";
    modal.updateTime = @"2021-09-08 12:23:34";
    modal.remainDay = @"26天";
    modal.expiryDate = @"2021-09-08 12:23:34";
    [panelView reloadData:modal];
    
    [panelView setReportCallback:^{
        //        自行处理引用问题
        [panelView close];
        IWPopupView *popView = [[IWPopupView alloc] init];
        
        NSArray *labels = @[@"电池突然断电", @"续航低于30公里", @"电池无法使用"];
        NSMutableArray *mArr = [NSMutableArray new];
        for (int i = 0; i < labels.count; i++) {
            IWPopupDataItem *item = [[IWPopupDataItem alloc] init];
            item.label = labels[i];
            item.id = [NSString stringWithFormat:@"%d", (int)i];
            [mArr addObject:item];
        }
        popView.data = [mArr copy];
        [popView show];
        [popView setCommitCallback:^(IWPopupDataItem * _Nonnull item, NSString * _Nonnull otherDes) {
            if (otherDes.length > 0) {
                NSLog(@"%@", otherDes);
            } else {
                NSLog(@"%@", item.label);
            }
        }];
    }];
    
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    
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
        _textFiled.userInteractionEnabled = YES;
    }
    return _textFiled;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
