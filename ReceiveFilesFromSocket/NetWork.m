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

@implementation NetWork

@synthesize delegate;
@synthesize viewController;

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        broadCastHost = @"192.168.1.109";
//        broadCastHost = @"127.0.0.1";
//        broadCastHost = @"222.20.59.197";
//        broadCastHost = @"202.114.20.91";
        
        
        
        mainPort = 12345;
        
        userName = @"zjj";
        
        mainFileType = NoneType;
        fileName = @"";
        
        [self initSocket];
        
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
//- (void)sendMessageWith:(NSString *)theMessage
//{
//    NSString * sendMessage = [NSString stringWithFormat:@"zjj : %@",theMessage];
//    NSData * sendData = [sendMessage dataUsingEncoding:NSUTF8StringEncoding];
//    [mainTcpSocket writeData:sendData withTimeout:-1 tag:1];
//}

#pragma mark - private methods

//- (NSString *)handleSendMessage:(NSString *)theSendMessage
//{
//    return [NSString stringWithFormat:@"%@ : %@" ,userName, theSendMessage];
//}

#pragma mark - AsyncSocket Delegate

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    viewController.mainImgView.image = [UIImage imageNamed:@"artwork"];
    NSLog(@"确认连接成功");
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"disconnect");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [mainTcpSocket readDataWithTimeout:-1 tag:1];
    
    if (fileLength == 0) {
        NSString * tempStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSArray * tempArray = [tempStr componentsSeparatedByString:@"+"];
        fileName = tempArray[0];
        fileLength = [(NSString *)tempArray[1] intValue];
        return;
    }
    
    [receiveData appendData:data];
    fileLength = fileLength - (int)[data length];
    if (fileLength == 0) {
        UIImage * receiveImg = [UIImage imageWithData:receiveData];
        viewController.mainImgView.image = receiveImg;
        receiveData = [[NSMutableData alloc] initWithLength:0];
    }
//    NSLog(@"%lu",(unsigned long)[data length]);
//    NSLog(@"%@",data);
    
    
//    if (mainFileType == NoneType) {
//        fileName = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    }
//    NSString * receiveMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    [self.delegate receiveMessageWith:receiveMessage];
//    NSLog(@"%@",receiveMessage);

//    if (!receiveMessage) {
//        [receiveData appendData:data];
//        UIImage * receiveImg = [UIImage imageWithData:data];
//        viewController.mainImgView.image = receiveImg;
//    }
//    
//    UIImage * receiveImg = [UIImage imageWithData:data];
//
//    viewController.mainImgView.image = receiveImg;

}



@end
