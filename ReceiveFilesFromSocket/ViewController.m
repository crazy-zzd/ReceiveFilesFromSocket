//
//  ViewController.m
//  ReceiveFilesFromSocket
//
//  Created by 朱 俊健 on 14-3-18.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import "ViewController.h"
#import "NetWork.h"


@interface ViewController ()

@end

@implementation ViewController

//@synthesize mainImgView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainNetWork = [[NetWork alloc] init];
    mainNetWork.delegate = self;
    
    [_fileProgress setHidden:YES];
    
    NSString * thePortStr = [NSString stringWithFormat:@"Port是服务器端的端口号\n默认为%d", NetWorkDefaultPort];
    thePortAlertView = [[UIAlertView alloc] initWithTitle:@"输入Port！" message:thePortStr delegate:nil cancelButtonTitle:@"保持默认" otherButtonTitles:@"修改",nil];
    [thePortAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    thePortAlertView.delegate = self;
    [thePortAlertView show];
    
    UITextField * textField = [thePortAlertView textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    NSString * theHostStr = [NSString stringWithFormat:@"Host是服务器端的iP地址\n默认地址为%@",NetWorkDefaultHost];
    theHostAlertView = [[UIAlertView alloc] initWithTitle:@"输入HOST！" message:theHostStr delegate:nil cancelButtonTitle:@"保持默认" otherButtonTitles:@"修改",nil];
    [theHostAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    theHostAlertView.delegate = self;
    [theHostAlertView show];
    textField = [theHostAlertView textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;

}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - receive message delegate
- (void)receiveMessageWith:(NSString *)theMessage
{
    _stateLabel.text = theMessage;
}

- (void)fileProgress:(float)theFilePercent
{
    [_fileProgress setHidden:NO];
    _fileProgress.progress = theFilePercent;
}

- (void)pngFile:(UIImage *)theFileImg
{
    [_textView removeFromSuperview];
    _textView = nil;
    [_mainImgView removeFromSuperview];
    _mainImgView = nil;
    _mainImgView = [[UIImageView alloc] initWithImage:theFileImg];
//    _mainImgView.frame = CGRectMake(0, 150, 320, 413);
    CGSize theImgSize = theFileImg.size;
    if (theImgSize.width / theImgSize.height > 320.0 / 413.0) {
        _mainImgView.frame = CGRectMake(0, 150, 320, theImgSize.height / theImgSize.width * 320);
    }
    else{
        _mainImgView.frame = CGRectMake(0, 150, theImgSize.width / theImgSize.height * 413, 413);
    }
    [self.view addSubview:_mainImgView];
}

- (void)textFile:(NSString *)theTextStr
{
    [_mainImgView removeFromSuperview];
    _mainImgView = nil;
    _textView.text = @"";
    [_textView removeFromSuperview];
    _textView = nil;
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 150, 320, 413)];
    _textView.font = [UIFont fontWithName:nil size:26];
    _textView.text = theTextStr;
    _textView.allowsEditingTextAttributes = NO;
    [_textView setEditable:NO];
    [self.view addSubview:_textView];
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && alertView == thePortAlertView) {
        [mainNetWork initSocket];
    }
    if (buttonIndex == 0) {
        return;
    }
    UITextField * theAlertViewTextField=[alertView textFieldAtIndex:0];
    if (alertView == theHostAlertView) {
        [mainNetWork setBroadCastHost:theAlertViewTextField.text];
    }
    else{
        [mainNetWork setMainPort:[theAlertViewTextField.text intValue]];
    }
}

@end
