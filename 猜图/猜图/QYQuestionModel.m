//
//  QYQuestionModel.m
//  猜图
//
//  Created by qingyun on 16/6/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYQuestionModel.h"

@implementation QYQuestionModel

- (instancetype)initWithDictionary:(NSDictionary *)dictData {
    self = [super init];
    if (self) {
        self.answer = dictData[@"answer"];
        self.icon = dictData[@"icon"];
        self.title = dictData[@"title"];
        self.options = dictData[@"options"];
        self.answerOfCount = self.answer.length;
    }
    
    return self;
  
}

+ (instancetype)questionWithDictionary:(NSDictionary *)dictData {
    
    QYQuestionModel *model = [[QYQuestionModel alloc] init];
    
    model.answer = dictData[@"answer"];
    model.icon = dictData[@"icon"];
    model.title = dictData[@"title"];
    model.options = dictData[@"options"];
    model.answerOfCount = model.answer.length;

        return model;
}

@end
