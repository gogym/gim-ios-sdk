//
//  Type.swift
//  gim
//
//  Created by imac on 2019/6/24.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit

struct Type{

    /**
     * 连接消息请求
     */
    static let CONNET_REQ:Int = 1;
    /**
     * 连接消息响应
     */
    static let  CONNET_RESP:Int = 2;
    
    /**
     * 进入群组消息请求
     */
    static let JOIN_GROUP_REQ:Int = 3;
    /**
     * 进入群组消息响应
     */
    static let JOIN_GROUP_RESP:Int = 4;
    
    /**
     * 点对点消息请求
     */
    static let SINGLE_MSG_REQ:Int = 5;
    /**
     * 点对点消息响应
     */
    static let SINGLE_MSG_RESP:Int = 6;
    
    /**
     * 群聊消息请求
     */
    static let GROUP_MSG_REQ:Int = 7;
    /**
     * 群聊消息响应
     */
    static let GROUP_MSG_RESP:Int = 8;
    
    
    /**
     * 添加好友请求
     */
    static let ADD_FRIEND_REQ = 9;
    
    /**
     * 添加好友响应
     */
    static let ADD_FRIEND_RESP = 10;
    
    /**
     * 心跳
     */
    static let HEART_BEAT_REQ:Int = 99;
    
    /**
     * ACK
     */
    static let ACK_REQ:Int = 100;
    
}
