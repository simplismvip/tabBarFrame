//
//  ViewController.m
//  TopBarFrame
//
//  Created by JM Zhao on 2017/2/28.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "ViewController.h"
#import "JMTopTableView.h"
#import "JMBottomCell.h"
#import "JMBottomView.h"
#import "JMTopBarModel.h"
#import "JMBottomModel.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < 7; i++) {
        
        JMTopBarModel *model = [[JMTopBarModel alloc] init];
        model.title = @"画笔";
        model.column = 1;
        NSMutableArray *bModels = [NSMutableArray array];
        NSInteger number = 3+arc4random()%4;
        NSLog(@"%ld", number);
        for (int j = 0; j < number; j ++) {
            
            JMBottomModel *bModel = [[JMBottomModel alloc] init];
            bModel.title = @"直线";
            bModel.isSelect = NO;
            bModel.image = @"more";
            [bModels addObject:bModel];
        }
        
        model.models = [bModels copy];
        [models addObject:model];
    }
    
    JMTopTableView *topbar = [[JMTopTableView alloc] initWithFrame:CGRectMake(0, 22, self.view.bounds.size.width, 44)];
    topbar.backgroundColor = [UIColor greenColor];
    topbar.dataSource = models;
    [self.view addSubview:topbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
