//
//  NetWork.h
//  GamePad4US
//
//  Created by 朱 俊健 on 13-12-12.
//  Copyright (c) 2013年 朱 俊健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "ReceiveMessageDelegate.h"

@class ViewController;

typedef enum FileType {
    NoneType ,
    TextType ,
    PngType
} FileType;

@interface NetWork : NSObject<AsyncSocketDelegate>{
    //socket
    AsyncSocket * mainTcpSocket;
    
    //发送的Host地址
    NSString * broadCastHost;
    
    //发送的端口
    int mainPort;
    
    //用户名
    NSString * userName;
    
    //文件类型
    FileType mainFileType;
    //文件名
    NSString * fileName;
    
    //文件
    int fileLength;
    NSMutableData * receiveData;
}

@property (nonatomic, weak) id<ReceiveMessageDelegate>delegate;
@property (nonatomic, strong) ViewController * viewController;

//对外接口
//发送消息
//-(void)sendMessageWith:(NSString *)theMessage;

@end
