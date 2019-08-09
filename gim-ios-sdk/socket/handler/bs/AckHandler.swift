//
//  AckHandler.swift
//  gim
//
//  Created by imac on 2019/7/24.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit

class AckHandler: AbsHandler<AckReq> {

    
    override func bodyClass() -> AckReq.Type {
        return AckReq.self;
    }
    
    
    
    override func handler(message: Message, bsBody: AckReq) {
        
        //返回消息ack说明服务器收到了
        print("接收服务器ack")
        
        
        
    }
}
