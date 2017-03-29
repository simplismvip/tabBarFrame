//
//  TopBarModel.h
//  TopBarFrame
//
//  Created by JM Zhao on 2017/2/28.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BottomModel.h"
@interface TopBarModel : NSObject
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger column;
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, assign) BOOL isSelect;
@end
