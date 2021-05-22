//
//  IWViewController.m
//  IWExtendUI
//
//  Created by LimMem on 05/21/2021.
//  Copyright (c) 2021 LimMem. All rights reserved.
//

#import "IWViewController.h"
#import <IWExtendUI/IWHeadPanelView.h>
#import <QMUIKit/QMUIKit.h>

@interface IWViewController ()

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
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
