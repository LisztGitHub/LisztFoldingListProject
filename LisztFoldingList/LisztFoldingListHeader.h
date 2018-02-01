//
//  LisztFoldingListHeader.h
//  LisztFoldingListProject
//
//  Created by LisztCoder on 2018/2/1.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 点击回调Block */
typedef void(^LisztFoldingLisztHeaderChangeCompletedBlock)(NSInteger clickIndex);

typedef NS_ENUM(NSUInteger, LisztFoldingListHeaderButtonStyle) {
    /** 多选 */
    LisztFoldingListHeaderButtonStyleMultiple,
    /** 单选 */
    LisztFoldingListHeaderButtonStyleRadio
};

@class LisztFoldingListHeaderButtonModel;
@interface LisztFoldingListHeader : UIView

/** 静态方法 */
+ (instancetype)headerWithFrame:(CGRect)frame changeCompleted:(LisztFoldingLisztHeaderChangeCompletedBlock)changeCompletedBlock;
/** 实例方法 */
- (instancetype)initWithFrame:(CGRect)frame changeCompleted:(LisztFoldingLisztHeaderChangeCompletedBlock)changeCompletedBlock;


#pragma mark - readonly
/** 左侧按钮 */
@property (nonatomic, readonly, strong) UIButton *leftButton;
/** 用来装载自定义按钮 */
@property (nonatomic, readonly, strong) UIView *contentView;
/** 右侧按钮 */
@property (nonatomic, readonly, strong) UIButton *rightArrow;

#pragma mark - readonly or readwrite
/** 回调 */
@property (nonatomic, copy) LisztFoldingLisztHeaderChangeCompletedBlock headerChangeCompletedBlock;
/** 哪一行 */
@property (nonatomic, assign) NSInteger section;
/** 是否展开 */
@property (nonatomic, assign) NSInteger show;
/** 触发回调 */
- (void)executeHeaderChangeCallbackClickIndex:(NSInteger)clickIndex;

@end
