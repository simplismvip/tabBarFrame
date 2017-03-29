//
//  JMBaseBottomTool.h
//  DrawRect
//
//  Created by JM Zhao on 2016/11/24.
//  Copyright © 2016年 yijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopBarModel;
@interface JMBaseBottomTool : UIView

+ (instancetype)initWithTopButton:(NSMutableArray<TopBarModel *> *)rows row:(NSInteger)row frame:(CGRect)rect;
@end
