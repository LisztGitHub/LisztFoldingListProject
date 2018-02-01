//
//  LisztFoldingListHeader.m
//  LisztFoldingListProject
//
//  Created by LisztCoder on 2018/2/1.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import "LisztFoldingListHeader.h"

@interface LisztFoldingListHeader()
{
    UIButton *_leftButton,*_rightArrow;
}
@end

@implementation LisztFoldingListHeader

+ (instancetype)headerWithFrame:(CGRect)frame changeCompleted:(LisztFoldingLisztHeaderChangeCompletedBlock)changeCompletedBlock{
    return [[LisztFoldingListHeader alloc] initWithFrame:frame changeCompleted:changeCompletedBlock];
}

- (instancetype)initWithFrame:(CGRect)frame changeCompleted:(LisztFoldingLisztHeaderChangeCompletedBlock)changeCompletedBlock{
    if(self == [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        if(changeCompletedBlock){
            self.headerChangeCompletedBlock = changeCompletedBlock;
        }
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)]];
    }
    return self;
}

- (void)setShow:(NSInteger)show{
    _show = show;
    if(_show){
        [self.leftButton setImage:[UIImage imageNamed:@"test_left_arrow"] forState:UIControlStateNormal];
    }
    else{
        [self.leftButton setImage:[UIImage imageNamed:@"test_left_arrow_down"] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.leftButton.frame = CGRectMake(10, 0, [self getWidthText:self.leftButton.titleLabel.text font:self.leftButton.titleLabel.font labelHeight:0] + 30, self.frame.size.height);
    self.rightArrow.frame = CGRectMake(CGRectGetWidth(self.frame) - 30 - 10, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
}

/** 回调 */
-(void)executeHeaderChangeCallbackClickIndex:(NSInteger)clickIndex{
    if(self.headerChangeCompletedBlock){
        self.headerChangeCompletedBlock(clickIndex);
    }
}

/** 点击手势 */
- (void)tapGestureRecognizer:(UITapGestureRecognizer *)recognizer{
    [self executeHeaderChangeCallbackClickIndex:self.section];
}

#pragma mark - Utils
/** 计算文本宽度 */
- (CGFloat)getWidthText:(NSString *)text font:(UIFont *)font labelHeight:(CGFloat)height{
    NSDictionary *attrDic = @{NSFontAttributeName:font};
    CGRect strRect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil];
    return strRect.size.width;
}

#pragma mark - 懒加载
- (UIButton *)leftButton{
    if(!_leftButton){
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:[UIImage imageNamed:@"test_left_arrow"] forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        leftButton.userInteractionEnabled = NO;
        [leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_leftButton = leftButton];
    }
    return _leftButton;
}
- (UIButton *)rightArrow{
    if(!_rightArrow){
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.userInteractionEnabled = NO;
        [rightButton setTitle:@"5/5" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:_rightArrow = rightButton];
    }
    return _rightArrow;
}

@end
