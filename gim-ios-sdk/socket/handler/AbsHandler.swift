//
//  AbsHandler.swift
//  gim
//
//  Created by imac on 2019/7/3.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit
import SwiftProtobuf

class AbsHandler<T:SwiftProtobuf.Message>:ChatBsProtocol {
    
    //业务分发
    func handler(message: Message) {
        
        var bsBody:T;
        do {
            //转换成特定的消息类型
            try bsBody=bodyClass().init(unpackingAny: message.body);
            handler(message:message,bsBody:bsBody);
            
        } catch  {
            print(error.localizedDescription)
        }
        
    }
    
    
    
//--------------------下面是子类必须要实现的方法--------------------------------
    
    //返回子类需要的泛型类
    func bodyClass()->T.Type{
        return T.self;
    }
    
    //执行子类业务处理方法
    func handler(message:Message,bsBody:T){}
    

}
