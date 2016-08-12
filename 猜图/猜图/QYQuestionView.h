//
//  QYQuestionView.h
//  猜图
//
//  Created by qingyun on 16/6/24.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYQuestionView : UIView

//每一组字典里面，21个选项小button的文字数组
@property (nonatomic,copy) NSArray *arrOptionsButtonWord;

//button的选择触发事件
@property (nonatomic,copy) void (^blkDidChooseButton) (NSString *strTitle);

+ (instancetype)questionView;

@end
