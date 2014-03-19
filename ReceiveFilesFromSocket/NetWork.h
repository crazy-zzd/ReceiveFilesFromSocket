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

extern NSString * const NetWorkDefaultHost;
extern int const NetWorkDefaultPort;

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
    
    //文件类型
    FileType mainFileType;
    //文件名
    NSString * fileName;
    //文件长度
    int fileLength;
    
    //接收到的文件
    NSMutableData * receiveData;
}

@property (nonatomic, weak) id<ReceiveMessageDelegate>delegate;
//@property (nonatomic, assign) int mainPort;
//@property (nonatomic, copy) NSString * broadCastHost;
//@property (nonatomic, strong) ViewController * viewController;

- (void)setMainPort:(int)theMainPort;
- (void)setBroadCastHost:(NSString *)theHost;

- (void)initSocket;

@end
