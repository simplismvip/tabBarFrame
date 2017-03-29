//
//  JMTopTableView.m
//  TopBarFrame
//
//  Created by JM Zhao on 2017/3/28.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "JMTopTableView.h"
#import "JMBottomCell.h"
#import "UIView+Extension.h"
#import "JMBottomView.h"
#import "JMTopBarModel.h"
#import "JMBottomModel.h"
#import "JMGestureButton.h"

#define JMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JMRandomColor JMColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define kH [UIScreen mainScreen].bounds.size.height
#define kW [UIScreen mainScreen].bounds.size.width
#define topBarTag 200

@interface JMTopTableView()<JMBottomViewDataSourceDelegate, JMBottomViewDelegate>
@property (nonatomic, assign) NSInteger section;
@end

@implementation JMTopTableView

- (void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    
    int i = 0;
    for (JMTopBarModel *model in dataSource) {
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [btn setTitle:model.title forState:(UIControlStateNormal)];
        btn.backgroundColor = JMRandomColor;
        btn.tag = i+topBarTag;
        [btn addTarget:self action:@selector(topBarAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn];
        i ++;
    }
}

- (void)topBarAction:(UIButton *)sender
{
    self.section = sender.tag-topBarTag;
    JMGestureButton *gesture = [JMGestureButton creatGestureButton];
    JMBottomView *bottom = [[JMBottomView alloc] initWithFrame:CGRectMake(0, self.superview.height, self.superview.width, 44)];
    [UIView animateWithDuration:0.1 animations:^{bottom.frame = CGRectMake(0, self.superview.height-44, self.superview.width, 44);}];
    // bottom.backgroundColor = [UIColor greenColor];
    bottom.dataSource = self;
    bottom.delegate = self;
    bottom.section = self.section;
    [gesture addSubview:bottom];
}

#pragma mark -- TopBarDataSourceDelegate
- (NSUInteger)numberOfRows
{
    JMTopBarModel *tModel = self.dataSource[self.section];
    return tModel.models.count;
}

- (NSUInteger)numberOfColumn
{
    JMTopBarModel *tModel = self.dataSource[self.section];
    return tModel.column;
}

// 返回cell
- (JMBottomCell *)tableView:(JMBottomView *)tableView index:(NSInteger)index
{
    JMBottomModel *bModel = [self.dataSource[self.section] models][index];
    JMBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bottom"];
    if (!cell) {cell = [[JMBottomCell alloc] init];}
    
    cell.isCellSelect = bModel.isSelect;
    cell.cellImage = bModel.image;
    cell.cellTitle = bModel.title;
    cell.cellTintColor = JMColor(90, 200, 93);
    
    return cell;
}

#pragma mark -- TopBarDelegate
- (void)tableView:(JMBottomView *)tableView didSelectRowAtIndex:(NSInteger)index
{
    JMBottomModel *bModel = [self.dataSource[self.section] models][index];
    bModel.isSelect = !bModel.isSelect;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int i = 0;
    CGFloat w = self.width/self.dataSource.count;
    for (UIView *view in self.subviews) {
        
        view.frame = CGRectMake(i*w, 0, w, self.height);
        i ++;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
