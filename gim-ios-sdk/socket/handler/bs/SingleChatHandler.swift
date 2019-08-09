//
//  SingleChatHandler.swift
//  gim
//
//  Created by imac on 2019/7/11.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit

class SingleChatHandler: AbsHandler<SingleChatReq> {

     weak var delegate:SingleChatDelegate?
    
    override func bodyClass() -> SingleChatReq.Type {
        return SingleChatReq.self;
    }
    
    
    
    override func handler(message: Message, bsBody: SingleChatReq) {
        
        delegate?.handler(message: message, bsBody: bsBody)
     
    }
}
