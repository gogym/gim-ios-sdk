//
//  BaseHandler.swift
//  gim
//
//  Created by imac on 2019/7/3.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit
import SwiftProtobuf

class BaseHandler: MessageReadProtocol {
    
    
    //实现接口方法
    func read(message: Message) {
        
        
        if(message.reqType != Type.ACK_REQ){
            
            //返回消息ack告诉服务器收到了
            let msg = MessageGen.createAck(ack: message.id);
            SocketClient.sharedInstance.sendMessage(msg: msg)
        }
        
        
        //获取消息请求类型
        let type:Int = Int(message.reqType);
        //根据类型获取消息处理器
        let absHandler = SocketConfig.sharedInstance.getHandler(type: type);
        
        if(absHandler != nil){
            absHandler?.handler(message: message);
        }else{
            print("没有对应的消息处理器")
        }
        
        
        
    }
    
    
}
