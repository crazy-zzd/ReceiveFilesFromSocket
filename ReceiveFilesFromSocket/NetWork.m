//
//  NetWork.m
//  GamePad4US
//
//  Created by 朱 俊健 on 13-12-12.
//  Copyright (c) 2013年 朱 俊健. All rights reserved.
//

#import "NetWork.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "ViewController.h"

NSString * const NetWorkDefaultHost = @"127.0.0.1";
int const NetWorkDefaultPort = 1234;

@implementation NetWork


@synthesize delegate;
//@synthesize mainPort;
//@synthesize broadCastHost;
//@synthesize viewController;

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        
        
        broadCastHost = NetWorkDefaultHost;
//        broadCastHost = @"127.0.0.1";
//        broadCastHost = @"222.20.59.197";
//        broadCastHost = @"202.114.20.91";
        
        mainPort = NetWorkDefaultPort;

//        [self initSocket];

        
        mainFileType = NoneType;
        
        fileName = @"";
        
        fileLength = 0;
        
        receiveData = [[NSMutableData alloc] initWithLength:0];
        
    }
    return self;
}

- (void)initSocket
{
    NSError * error = Nil;
    
    mainTcpSocket = [[AsyncSocket alloc] initWithDelegate:self];
    if (![mainTcpSocket connectToHost:broadCastHost onPort:mainPort error:&error]) {
        NSLog(@"连接消息发送失败,error:%@",error);
    }
    else{
        NSLog(@"连接消息发送成功！");
    }
    [mainTcpSocket readDataWithTimeout:-1 tag:1];
}



#pragma mark - 对外接口

- (void)setBroadCastHost:(NSString *)theHost
{
    broadCastHost = theHost;
}

- (void)setMainPort:(int)theMainPort
{
    mainPort = theMainPort;
    [self initSocket];
}

#pragma mark - private methods

- (BOOL)isPNGFiles:(NSString *)theFileName
{
    NSString * suffix = [theFileName substringFromIndex:[theFileName length] - 4];
    if ([suffix isEqualToString:@".png"]) {
        return YES;
    }
    return NO;
}

#pragma mark - AsyncSocket Delegate

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"确认连接成功");
    [self.delegate receiveMessageWith:@"连接成功"];
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"断开连接");
    [self.delegate receiveMessageWith:@"已断开连接"];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [mainTcpSocket readDataWithTimeout:-1 tag:1];
    
    if (fileLength == 0) {
        NSString * tempStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSArray * tempArray = [tempStr componentsSeparatedByString:@"+"];
        fileName = tempArray[0];
        fileLength = [(NSString *)tempArray[1] intValue];
        
        if ([self isPNGFiles:fileName]) {
            mainFileType = PngType;
        }
        else{
            mainFileType = TextType;
        }
        return;
    }
    
    [receiveData appendData:data];
    NSLog(@"正在传输文件：%f", 1 - (fileLength - [receiveData length]) / (float)fileLength);
    [self.delegate receiveMessageWith:@"正在传输文件"];
    [self.delegate fileProgress:1 - (fileLength - [receiveData length]) / (float)fileLength];
    if (fileLength == [receiveData length]) {
        if (mainFileType == PngType) {
            UIImage * receiveImg = [UIImage imageWithData:receiveData];
            [self.delegate pngFile:receiveImg];
//            viewController.mainImgView.image = receiveImg;
        }
        else{
            NSString * receiveMessage = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",receiveMessage);
            [self.delegate textFile:receiveMessage];
        }
        NSLog(@"传输成功");
        [self.delegate receiveMessageWith:@"传输成功"];
        receiveData = [[NSMutableData alloc] initWithLength:0];
        fileLength = 0;
    }
}
@end
