//
//  ViewController.h
//  ReceiveFilesFromSocket
//
//  Created by 朱 俊健 on 14-3-18.
//  Copyright (c) 2014年 朱 俊健. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetWork;

@interface ViewController : UIViewController{
    NetWork * mainNetWork;
}

@property (nonatomic, strong) UIImageView * mainImgView;

@end
