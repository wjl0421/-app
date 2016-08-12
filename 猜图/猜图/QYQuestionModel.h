//
//  QYQuestionModel.h
//  猜图
//
//  Created by qingyun on 16/6/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYQuestionModel : NSObject
//model的属性
@property (nonatomic,copy) NSString *answer;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSArray *options;

//当前答案的长度
@property (nonatomic) NSInteger answerOfCount;
@property (nonatomic)BOOL isFinish;

@property (nonatomic) BOOL isHint;

//- (instancetype)initWithDictionary:(NSDictionary *)dictData;

+ (instancetype)questionWithDictionary:(NSDictionary *)dictData;

@end
