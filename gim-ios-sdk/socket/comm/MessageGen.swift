//
//  MessageGen.swift
//  gim
//
//  Created by imac on 2019/6/24.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit
import SwiftProtobuf

class MessageGen: NSObject {
    
    
    
    //MARK:创建文本消息
    class func createGroupTextMsg(senderId:String,groupId:String,text:String)->Data{
        
        
        var data:Data=Data.init();
        
        var messageBuilder = Message.init();
        messageBuilder.identify = Const.identify;
        messageBuilder.version = Const.version;
        messageBuilder.reqType = Int32(Type.GROUP_MSG_REQ);
        messageBuilder.msgTime=Int64(DateTimeUtil.getCurrentTime());
        messageBuilder.id = UUID().uuidString;
        
        var groupChatReq = GroupChatReq.init();
        groupChatReq.senderID=senderId
        groupChatReq.groupID=groupId
        groupChatReq.msgType=Int32(MsgType.MSG_TYPE_TEXT)
        groupChatReq.body=text
        
        do {
            
            messageBuilder.body = try Google_Protobuf_Any(message: groupChatReq);
            let stream1 = OutputStream.toMemory()
            stream1.open()
            try BinaryDelimited.serialize(message: messageBuilder, to: stream1);
            stream1.close()
            let nsData = stream1.property(forKey: .dataWrittenToMemoryStreamKey) as! NSData
            data = Data(referencing: nsData)
            
        } catch {
            print(error)
        }
        return data;
        
        
    }
    
    
    
    //MARK:创建文本消息
    class func createTextMsg(senderId:String,receiverId:String,text:String)->Data{
        
        
        var data:Data=Data.init();
        
        var messageBuilder = Message.init();
        messageBuilder.identify = Const.identify;
        messageBuilder.version = Const.version;
        messageBuilder.reqType = Int32(Type.SINGLE_MSG_REQ);
        messageBuilder.msgTime=Int64(DateTimeUtil.getCurrentTime());
        messageBuilder.id = UUID().uuidString;
        
        var singleChatReq = SingleChatReq.init();
        singleChatReq.senderID=senderId
        singleChatReq.receiverID=receiverId
        singleChatReq.msgType=Int32(MsgType.MSG_TYPE_TEXT)
        singleChatReq.body=text
        
        do {
            
            messageBuilder.body = try Google_Protobuf_Any(message: singleChatReq);
            let stream1 = OutputStream.toMemory()
            stream1.open()
            try BinaryDelimited.serialize(message: messageBuilder, to: stream1);
            stream1.close()
            let nsData = stream1.property(forKey: .dataWrittenToMemoryStreamKey) as! NSData
            data = Data(referencing: nsData)
            
        } catch {
            print(error)
        }
        return data;
        
        
    }
    
    
    /*创建ack*/
    class func createAck(ack:String) -> Data{
        
        var data:Data=Data.init();
        
        var messageBuilder = Message.init();
        messageBuilder.identify = Const.identify;
        messageBuilder.version = Const.version;
        messageBuilder.reqType = Int32(Type.ACK_REQ);
        messageBuilder.msgTime=Int64(DateTimeUtil.getCurrentTime());
        messageBuilder.id = UUID().uuidString;
        
        var ackReq = AckReq.init();
        ackReq.ack=ack;
        
        do {
            
            messageBuilder.body = try Google_Protobuf_Any(message: ackReq);
            let stream1 = OutputStream.toMemory()
            stream1.open()
            try BinaryDelimited.serialize(message: messageBuilder, to: stream1);
            stream1.close()
            let nsData = stream1.property(forKey: .dataWrittenToMemoryStreamKey) as! NSData
            data = Data(referencing: nsData)
            
        } catch {
            print(error)
        }
        return data;
    }
    
    
    /*创建心跳消息*/
    class func createHeartBeat() ->Data{
        
        var data:Data=Data.init();
        
        var messageBuilder = Message.init();
        messageBuilder.identify = Const.identify;
        messageBuilder.version = Const.version;
        messageBuilder.reqType = Int32(Type.HEART_BEAT_REQ);
        messageBuilder.msgTime=Int64(DateTimeUtil.getCurrentTime());
        messageBuilder.id = UUID().uuidString;
        
        let heartReq = HeartBeatReq.init();
        
        do {
            
            messageBuilder.body = try Google_Protobuf_Any(message: heartReq);
            let stream1 = OutputStream.toMemory()
            stream1.open()
            try BinaryDelimited.serialize(message: messageBuilder, to: stream1);
            stream1.close()
            let nsData = stream1.property(forKey: .dataWrittenToMemoryStreamKey) as! NSData
            data = Data(referencing: nsData)
            
        } catch {
            print(error)
        }
        
        return data
    }
    
    
    /*发送用户连接请求*/
    class func createConnect(senderId:String) ->Data{
        
        
        var data:Data=Data.init();
        
        var message = Message.init();
        message.identify = Const.identify;
        message.version = Const.version;
        message.reqType = Int32(Type.CONNET_REQ);
        message.msgTime=Int64(DateTimeUtil.getCurrentTime())
        message.id = UUID().uuidString;
        
        var connectReq = ConnectReq.init();
        connectReq.senderID = senderId
        
        do {
            message.body = try Google_Protobuf_Any(message: connectReq);
            
            
            
            let stream1 = OutputStream.toMemory()
            stream1.open()
            try BinaryDelimited.serialize(message: message, to: stream1);
            stream1.close()
            let nsData = stream1.property(forKey: .dataWrittenToMemoryStreamKey) as! NSData
            data = Data(referencing: nsData)
        } catch {
            print(error)
        }
        
        return data
    }
    
}
