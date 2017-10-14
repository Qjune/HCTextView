//
//  ViewController.m
//  HCTextViewWithPlaceHolder
//
//  Created by 微微笑了 on 2017/10/14.
//  Copyright © 2017年 微微笑了. All rights reserved.
//

#import "ViewController.h"
#import "HCTextView.h"

@interface ViewController () <UITextViewDelegate>

@property (strong, nonatomic) HCTextView *textView;
@property (strong, nonatomic) UILabel * numLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _textView = [[HCTextView alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 140)];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = TEXTFONTSIZE(13);
    _textView.textColor = RGB(66, 66, 66, 1);
    _textView.haveLayer = YES;
    [_textView setTextViewLayerCornerRadius:5.0 borderWidth:1.0 borderColor:[UIColor orangeColor]];
    _textView.delegate = self;
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.placeholder = @"textView也可以有placeholder...";
    _textView.autocapitalizationType = UITextAutocapitalizationTypeNone;//取消首字母大写
    _textView.placeholderColor = RGB(153, 153, 153, 1);
    _textView.placeholderFont = TEXTFONTSIZE(12);
    [self.view addSubview:_textView];
    
    _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_textView.frame)-90, CGRectGetMaxY(_textView.frame)+6, 80, 21)];
    _numLabel.textAlignment = NSTextAlignmentRight;
    _numLabel.text = [NSString stringWithFormat:@"%ld/80",_textView.text.length];
    _numLabel.backgroundColor = [UIColor clearColor];
    _numLabel.font = TEXTFONTSIZE(12);
    _numLabel.textColor = RGB(153, 153, 153, 1);
    [self.view addSubview:_numLabel];
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    //在这个地方计算输入的字数
    NSInteger wordCount = textView.text.length;
    self.numLabel.text = [NSString stringWithFormat:@"%ld/80",(long)wordCount];
}

#pragma mark 超过80字
//限制输入字数
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (textView == self.textView) {
        if (text.length == 0) return YES;
        
        NSInteger existedLength = textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = text.length;
        if (existedLength - selectedLength + replaceLength > 80) {
            return NO; //字数大于80则不能输入，但是可以删除后在输入，网上有很多都不能再操作了
        }
    }
    return YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
