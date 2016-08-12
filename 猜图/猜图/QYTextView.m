//
//  QYTextView.m
//  猜图
//
//  Created by qingyun on 16/6/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYTextView.h"

static CGFloat const QYMeiYiGeXiaoButtonWidth = 40;
static CGFloat const QYMeiYiGeXiaoButtonHeight = 40;
static CGFloat const QYLiangGeXiaoButtonJianXi = 10;

@interface QYTextView ()

{
    //当前用户输入的文字的个数
    NSInteger _currentWordCount;
}
//这里不能用copy？===============================
@property (nonatomic,strong) NSMutableArray *arrMXiangYingGeShuArray;
@end

@implementation QYTextView

- (NSMutableArray *)arrMXiangYingGeShuArray {
    if (!_arrMXiangYingGeShuArray) {
        
        NSUInteger count = self.strAnswerZhengQueDaAn.length;
        _arrMXiangYingGeShuArray = [NSMutableArray arrayWithCapacity:count];
        for (NSUInteger index = 0; index < count; index++) {
            
            [_arrMXiangYingGeShuArray addObject:@""];
        }
    }
    return _arrMXiangYingGeShuArray;
}

+ (instancetype)textViewYouJiGezi:(NSUInteger)count
{
    QYTextView * weiZhiDaAnView = [QYTextView new];
    CGFloat weiZhiDaAnViewWidth = (count * QYMeiYiGeXiaoButtonWidth) + (count - 1) * QYLiangGeXiaoButtonJianXi;
    
    weiZhiDaAnView.bounds = CGRectMake(0, 0, weiZhiDaAnViewWidth, QYMeiYiGeXiaoButtonHeight);
    //weiZhiDaAnView.backgroundColor = [UIColor redColor];
    
    for (NSUInteger index = 0; index < count; index ++) {
        
        UIButton *weiZhiDaAnViewDeXiaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat xiaoButtonX = index * (QYMeiYiGeXiaoButtonWidth + QYLiangGeXiaoButtonJianXi);
        weiZhiDaAnViewDeXiaoButton.frame = CGRectMake(xiaoButtonX, 0, QYMeiYiGeXiaoButtonWidth, QYMeiYiGeXiaoButtonHeight);
        [weiZhiDaAnViewDeXiaoButton setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [weiZhiDaAnViewDeXiaoButton setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        [weiZhiDaAnViewDeXiaoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [weiZhiDaAnView addSubview:weiZhiDaAnViewDeXiaoButton];
    
    
    }
    return weiZhiDaAnView;
    
}

//传入一个文字并赋值到对应的button上
- (void)pushWord:(NSString *)strWord
{
   //先取出答案文字的个数
    NSInteger count = self.strAnswer.length;
    
    if (_currentWordCount < count) {
     //遍历所有的数组中的内容是不是空字符串
        for (NSUInteger index = 0; index<count; index++) {
            
            //把数组中第一个为空的元素替换成传进来的标题
            if ([self.arrMXiangYingGeShuArray[index] isEqualToString:@""]) {
                
                //替换数组中的内容
                [self.arrMXiangYingGeShuArray replaceObjectAtIndex:index withObject:strWord];
                
                //设置对应的button的标题
                UIButton *btnWord = self.subviews[index];
                [btnWord setTitle:strWord forState:UIControlStateNormal];
                _currentWordCount ++;
                break;
            }
        }
        //判断当输入当前这个字个时候文字应该显示什么颜色
        NSString *strResultTemp = [self.arrMXiangYingGeShuArray componentsJoinedByString:@""];
        if ([strResultTemp isEqualToString:self.strAnswer]) {//用户输入和答案是相等的
            if (self.blkDidCompleteCollectting) {
                
                self.blkDidCompleteCollectting(YES);
            }else {//用户的输入和答案不等
                
                if (_currentWordCount == self.strAnswer.length) {
                    
                    if (self.blkDidCompleteCollectting) {
                        self.blkDidCompleteCollectting(NO);
                    }
                }
            }
            
            //修改颜色
            [self judgeColor];
        }
        
        
    }
   
    
    
    
}

- (void)judgeColor {
    
    NSString *strResultTemp = [self.arrMXiangYingGeShuArray componentsJoinedByString:@""];
    if ([strResultTemp isEqualToString:self.strAnswer]) {
        
        //用户输入和答案是相等的
        [self updateTitleColor:[UIColor greenColor]];
    }else {//用户的输入和答案不等
        
        if (_currentWordCount == self.strAnswer.length) {
            
            //长度一样但是答案是错误的
            [self updateTitleColor:[UIColor redColor]];
        } else {
            //长度不一样
            [self updateTitleColor:[UIColor blackColor]];
        }
    }
}


- (void)updateTitleColor:(UIColor *)color {
    
    NSArray *arrSubViews = self.subviews;
    NSUInteger count = arrSubViews.count;
    for (NSUInteger index = 0; index<count; index++) {
        
        UIButton *button = arrSubViews[index];
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    
}








@end
