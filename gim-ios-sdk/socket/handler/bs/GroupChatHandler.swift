//
//  GroupChatHandler.swift
//  gim
//
//  Created by imac on 2019/7/11.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit

class GroupChatHandler: AbsHandler<GroupChatReq>  {

    weak var delegate:GroupChatDelegate?
    
    override func bodyClass() -> GroupChatReq.Type {
        return GroupChatReq.self;
    }
    
    
    
    override func handler(message: Message, bsBody: GroupChatReq) {
        
        delegate?.handler(message: message, bsBody: bsBody)
        
    }
}
