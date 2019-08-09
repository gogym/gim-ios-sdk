//
//  AddFriendHandler.swift
//  gim
//
//  Created by imac on 2019/7/4.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit

class AddFriendHandler:  AbsHandler<AddFriendReq> {

  
    weak var delegate:AddFriendDelegate?
    
    
    override func bodyClass() -> AddFriendReq.Type {
        return AddFriendReq.self;
    }
    
    
    override func handler(message: Message, bsBody: AddFriendReq) {
        //从代理中发出去
        delegate?.handler(message: message,bsBody:bsBody )
    }
}
