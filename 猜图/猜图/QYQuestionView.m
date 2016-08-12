//
//  QYQuestionView.m
//  猜图
//
//  Created by qingyun on 16/6/24.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYQuestionView.h"

@implementation QYQuestionView

+(instancetype)questionView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"QYQuestionView" owner:nil options:nil] firstObject];
}

//设置每一组字典里面options的21个小button的标题item
- (void)setArrOptionsButtonWord:(NSArray *)arrOptionsButtonWord
{
    _arrOptionsButtonWord = [arrOptionsButtonWord copy];
    //取出所有的子视图，子视图也就是那21个小button
    NSArray *arrSubviews = self.subviews;
    //子视图的个数
    NSUInteger count = self.subviews.count;
    
    //遍历所有的子视图
    for (NSUInteger index = 0; index < count; index ++) {
        
        //在索引为index下的view
        UIView *view = arrSubviews[index];
        //判断这个view是不是一个UIbutton
        if ([view isKindOfClass:[UIButton class]]) {
            
            //需要强制转换button
            UIButton *btnOption = (UIButton *)view;
            [btnOption setTitle:arrOptionsButtonWord[index] forState:UIControlStateNormal];
            [btnOption addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
}
 //按钮的触发事件，实现这个chooseAction：方法，在里面调用blkDidChooseButton这个block块
-(void)chooseAction:(UIButton *)button
    {
        if (self.blkDidChooseButton) {
            self.blkDidChooseButton([button titleForState:UIControlStateNormal]);
        }
    }
    
    
    
    
    



@end
