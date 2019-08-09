//
//  AddFriendRespHandler.swift
//  gim
//
//  Created by imac on 2019/7/4.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit

class AddFriendRespHandler: AbsHandler<AddFriendResp> {
    

    override func bodyClass() -> AddFriendResp.Type {
        return AddFriendResp.self;
    }
    
    
    override func handler(message: Message, bsBody: AddFriendResp) {
        print("好友添加请求")
        
        
        
        
    }
    
    
    
    
}
