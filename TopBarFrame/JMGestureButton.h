//
//  JMGestureButton.h
//  YaoYao
//
//  Created by JM Zhao on 2016/11/19.
//  Copyright © 2016年 JunMingZhaoPra. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMGestureButtonDelegate <NSObject>
- (void)didRemove;
@end

@interface JMGestureButton : UIButton
@property (nonatomic, weak) id <JMGestureButtonDelegate>delegate;
+ (JMGestureButton *)creatGestureButton;
- (void)rem_GestureBtn:(JMGestureButton *)sender;
@end
