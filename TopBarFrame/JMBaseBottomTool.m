//
//  JMBaseBottomTool.m
//  DrawRect
//
//  Created by JM Zhao on 2016/11/24.
//  Copyright © 2016年 yijia. All rights reserved.
//

#import "JMBaseBottomTool.h"
#import "TopBarModel.h"
#import "JMButtom.h"
#import "UIView+Extension.h"

#define JMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define baseTag 100

@interface JMBaseBottomTool()
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) NSInteger btnNumbers;
@end

@implementation JMBaseBottomTool

+ (instancetype)initWithTopButton:(NSMutableArray<TopBarModel *> *)rows row:(NSInteger)row frame:(CGRect)rect
{
    JMBaseBottomTool *cu = [[self alloc] initWithFrame:rect];
    cu.row = row;
    cu.btnNumbers = rows.count;
    cu.backgroundColor = JMColor(245, 245, 245);
    
    for (int i = 0; i < cu.btnNumbers; i ++) {
        
        JMButtom *btn = [[JMButtom alloc] init];
        TopBarModel *model = rows[i];
        if (model.isSelect) {btn.backgroundColor = JMColor(205, 205, 205);
        }else{btn.backgroundColor = JMColor(245, 245, 245);}
        // [btn setImage:[[UIImage imageNamed:model.imageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)] forState:0];
        // [btn setTitle:model.showName forState:0];
        [btn setTitleColor:JMColor(90, 200, 93) forState:0];
        [btn setTintColor:JMColor(90, 200, 93)];
        btn.tag = baseTag+i;
        [btn addTarget:cu action:@selector(customBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [cu addSubview:btn];
    }
    
    return cu;
}

- (void)customBtnAction:(JMButtom *)btn
{

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger e = 10;
    NSInteger n = self.btnNumbers/self.row;
    CGFloat m = (CGFloat)self.btnNumbers/self.row;
    
    NSInteger column;
    if (m>n) {column = n+1;
    }else{column = n;}
    
    CGFloat w = (self.width-(column+1)*e)/column;
    CGFloat h = (self.height-(self.row+1)*e)/self.row;
    
    int k = 0;
    for (int i = 0; i < self.row; i ++) {
        
        for (int j = 0; j< column; j ++) {
        
            if (k<self.btnNumbers) {
            
                UIView *v = self.subviews[k];
                v.frame = CGRectMake((w+e)*j+e, e+i*(h+e), w, h);
            }
            k++;
        }
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
