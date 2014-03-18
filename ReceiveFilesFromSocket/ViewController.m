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

@synthesize mainImgView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainNetWork = [[NetWork alloc] init];
    
    mainNetWork.viewController = self;
    
    mainImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    mainImgView.image = [UIImage imageNamed:@"artwork"];
    
    [mainImgView setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:mainImgView];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
