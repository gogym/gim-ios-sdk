//
//  HearBeatHandler.swift
//  gim
//
//  Created by imac on 2019/6/21.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit
import SwiftProtobuf

class HeartBeatHandler: NSObject {
    
    //单利模式
    static let heartBeatHandler=HeartBeatHandler();
    private override init() {}
    
    var heartTimer:Timer?
    var socket:GCDAsyncSocket?
    
    //开始心跳
    func startHeartBeat(socket:GCDAsyncSocket) -> Void {
        
        self.socket=socket;
        //启动一个定时器执行心跳
        heartTimer=Timer.scheduledTimer(timeInterval: 30, target:self, selector:#selector(hearBeatHandler), userInfo: nil, repeats: true);
        heartTimer!.fire();
    }
    
    //停止发送心跳
    func stopHeartBeat() -> Void {
        heartTimer?.invalidate()
    }
    
    
    //MARK:心跳
    @objc func hearBeatHandler() -> Void {
        
        print("心跳")
        
        let data = MessageGen.createHeartBeat();
        self.socket?.write(data, withTimeout: -1, tag: 0);
 
    }
}
