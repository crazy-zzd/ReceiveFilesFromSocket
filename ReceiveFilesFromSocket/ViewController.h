//
//  ViewController.h
//  ReceiveFilesFromSocket
//
//  Created by 朱 俊健 on 14-3-18.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReceiveMessageDelegate.h"

@class NetWork;

@interface ViewController : UIViewController<ReceiveMessageDelegate,UIAlertViewDelegate>{
    NetWork * mainNetWork;
    
    UIAlertView * theHostAlertView;
    UIAlertView * thePortAlertView;
}

@property (nonatomic, strong) UIImageView * mainImgView;
@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) IBOutlet UILabel * stateLabel;
@property (nonatomic, strong) IBOutlet UIProgressView * fileProgress;


@end
