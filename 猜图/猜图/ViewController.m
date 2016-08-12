//
//  ViewController.m
//  猜图
//
//  Created by qingyun on 16/6/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "QYQuestionModel.h"
#import "QYTextView.h"
#import "QYQuestionView.h"

@interface ViewController ()
{
    NSInteger _index;
    __weak IBOutlet UIView *_textViewRongQi;
    
    //容纳questions.plist全部内容的数组的当前的索引，也就是数组元素的第几个(数组里面是一个一个的字典，里面各有4种属性)
    NSInteger _indexCurrent;
    __weak QYQuestionView *_questionView;
    __weak QYTextView *_textView;
    
}
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIButton *JinBIButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic,copy) NSArray *arrResources;

@end

@implementation ViewController

- (NSArray *)arrResources {
    
    if (!_arrResources) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"questions" withExtension:@"plist"];
        
        _arrResources = [NSArray arrayWithContentsOfURL:url];
        
        NSInteger count = _arrResources.count;
        
        //新建一个有特定容量的可变数组
        NSMutableArray *arrMResources = [NSMutableArray arrayWithCapacity:count];
        
        //字典转模型，最后添加到可变数组中
        for (_index = 0; _index < count; _index ++) {
            
            NSDictionary *dictData = _arrResources[_index];
            QYQuestionModel *question = [QYQuestionModel questionWithDictionary:dictData];
            [arrMResources addObject:question];
            
        }
        _arrResources = [arrMResources copy];
       
    }
    return _arrResources;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateUIWithQuestion:self.arrResources[_indexCurrent]];
    
    [self loadQYQuestionView:_arrResources[_indexCurrent]];
}

//加载默认的UI--这里是为了加载QYQuestionView上的21个小button,显示出来
- (void)loadQYQuestionView:(QYQuestionModel *)question {
    
    QYQuestionView *questionView = [QYQuestionView questionView];
    CGFloat questionViewCenterY = CGRectGetMaxY(_textViewRongQi.frame) + 20 + questionView.bounds.size.height * 0.5;
    questionView.center = CGPointMake(self.view.center.x, questionViewCenterY);
    _questionView = questionView;
    
    //设置questionView的数据================
     _questionView.arrOptionsButtonWord = question.options;
    [self.view addSubview:questionView];
    //接收QYQuestionView的block，把信息传给QYTextView
    [_questionView setBlkDidChooseButton:^(NSString *strTitle) {
        
        [_textView pushWord:strTitle];
    }];
    
    
}


- (IBAction)btnTap:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
            
            break;
            
        case 2:
            [self fangDaImage:sender];
            
            break;
            
        case 3:
            
            break;
         //下一题
        case 4:
            [self next];
            
            break;
            
        default:
            break;
    }
    
}

- (void)next {
    
    _index ++;
    [self gengXinUI];
}

- (void)gengXinUI {
    
    //让下一题button点不动
//    self.btnNext.enabled = _index == self.arrResources.count -1 ? NO : YES;
    
      NSInteger index =  ++_indexCurrent;
    if (index == 10) {
        _indexCurrent = 0;
    }
    [self updateUIWithQuestion:self.arrResources[_indexCurrent]];
}

//更新UI数据--这里主要是更新模型里面的4个属性的数据，同时这是在搭建textView上的小button，因为小button的个数不确定，所以需要动态的加载QYTtextView
- (void)updateUIWithQuestion:(QYQuestionModel *)question {
    
    //num/total
    _number.text = [NSString stringWithFormat:@"%ld/%ld",_indexCurrent+1,self.arrResources.count];
        
    //description描述字典里面的title属性
    _titleName.text = question.title;
    
    //加载imageview里面的图片
    _imageView.image = [UIImage imageNamed:question.icon];
    
    //动态加载QYTextView--开始布局textview上的小button
    //每一次都要把textview移除一下，否则textView小button 不会显示一个一个的
    [_textView removeFromSuperview];
    QYTextView *textView = [QYTextView textViewYouJiGezi:question.answer.length];
    CGSize sizeTextView = _textViewRongQi.bounds.size;
    textView.center = CGPointMake(sizeTextView.width/2, sizeTextView.height/2);
    
    textView.strAnswerZhengQueDaAn = question.answer;
    textView.strAnswer = question.answer;
    _textView = textView;
    [_textViewRongQi addSubview:textView];
    
    //设置questionView的数据
    _questionView.arrOptionsButtonWord = question.options;
    
}

- (void)fangDaImage:(UIButton *)button {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    
    btn.frame = self.view.frame;
    btn.backgroundColor = [UIColor magentaColor];
    btn.alpha = 0;
    [btn addTarget:self action:@selector(suoFang:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.25 animations:^{
        _imageView.transform = CGAffineTransformScale(_imageView.transform, 1.8, 1.8);
        btn.alpha = 0.5;
    }];
}

- (void)suoFang:(UIButton *)button {
    
    [UIView animateWithDuration:0.25 animations:^{
        _imageView.transform = CGAffineTransformIdentity;
        button.alpha = 0;
    }];
}




@end
