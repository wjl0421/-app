//
//  QYTextView.h
//  猜图
//
//  Created by qingyun on 16/6/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYQuestionModel.h"

@interface QYTextView : UIView

@property (nonatomic,copy)void(^blkDidCompleteCollectting)(BOOL isRight);

@property (nonatomic,copy) NSString *strAnswerZhengQueDaAn;
@property (nonatomic,copy)NSString *strAnswer;
+ (instancetype)textViewYouJiGezi:(NSUInteger)count;

//这个方法是用来传递QYQuestionView里面的block内容，点击QYQuestionView里面的任一个21个小button，都会把点击的那个标题先让控制器接收到，然后再传递给QYTextView里面的这个方法
- (void)pushWord:(NSString *)strWord;

@end
