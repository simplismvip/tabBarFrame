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
#import "TopBarModel.h"

#define JMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JMRandomColor JMColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define kH [UIScreen mainScreen].bounds.size.height
#define kW [UIScreen mainScreen].bounds.size.width
#define topBarTag 200

@interface JMTopTableView()<JMBottomViewDataSourceDelegate, JMBottomViewDelegate>
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) JMBottomView *bottom;
@end

@implementation JMTopTableView

- (JMBottomView *)bottom
{
    if (!_bottom) {
        
        self.bottom = [[JMBottomView alloc] initWithFrame:CGRectMake(0, self.superview.height, self.superview.width, 44)];
        _bottom.backgroundColor = [UIColor greenColor];
        _bottom.dataSource = self;
        _bottom.delegate = self;
        [self.superview addSubview:_bottom];
    }
    
    return _bottom;
}

- (void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    
    int i = 0;
    for (TopBarModel *model in dataSource) {
        
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
    [self showBottomView:self.section];
    [self.bottom reloadData];
}

#pragma mark -- TopBarDataSourceDelegate
- (NSUInteger)numberOfRows
{
    TopBarModel *tModel = self.dataSource[self.section];
    NSLog(@"count %ld", tModel.models.count);
    return tModel.models.count;
}

- (NSUInteger)numberOfColumn
{
    TopBarModel *tModel = self.dataSource[self.section];
    return tModel.column;
}

// 返回cell
- (JMBottomCell *)tableView:(JMBottomView *)tableView index:(NSInteger)index
{
    JMBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bottom"];
    if (!cell) {cell = [[JMBottomCell alloc] init];}
    cell.backgroundColor = JMRandomColor;
    return cell;
}

#pragma mark -- TopBarDelegate
- (void)tableView:(JMBottomView *)tableView didSelectRowAtIndex:(NSInteger)index
{
    NSLog(@"选中第%ld--%ld", index, tableView.section);
}

#pragma mark -- JMGestureButtonDelegate
- (void)showBottomView:(NSInteger)section
{
    UIButton *gesture = [UIButton buttonWithType:(UIButtonTypeSystem)];
    gesture.frame = CGRectMake(0, CGRectGetMinY(self.bounds), self.width, self.superview.height-44);
    gesture.backgroundColor = [UIColor clearColor];
    [gesture addTarget:self action:@selector(rem_GestureBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.superview addSubview:gesture];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        for (UIView *view in self.bottom.subviews) {[view removeFromSuperview];}
        self.bottom.frame = CGRectMake(0, self.superview.height-44, self.superview.width, 44);
        self.bottom.section = section;
    }];
}

- (void)rem_GestureBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        
        [sender removeFromSuperview];
        self.bottom.frame = CGRectMake(0, self.superview.height, self.superview.width, 44);
    }];
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
