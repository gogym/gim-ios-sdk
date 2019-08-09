//
//  ChatBsProtocol.swift
//  gim
//
//  Created by imac on 2019/7/3.
//  Copyright © 2019 gim. All rights reserved.
//

import SwiftProtobuf

protocol ChatBsProtocol{
    //消息处理
   func handler(message:Message);
    
    
}

//拓展这个protocol，使方法变为可选实现
extension ChatBsProtocol {
    func handler(message:Message) {
       
    }

}



