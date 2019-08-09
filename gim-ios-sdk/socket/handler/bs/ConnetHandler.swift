//
//  xxxhandler.swift
//  gim
//
//  Created by imac on 2019/7/3.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit

class ConnetHandler: AbsHandler<ConnectResp> {

     weak var delegate:ConnectDelegate?
    
    override func bodyClass() -> ConnectResp.Type {
        return ConnectResp.self;
    }
    
    
    
    override func handler(message: Message, bsBody: ConnectResp) {
        
       delegate?.bindUserSuccess(message: message, bsBody: bsBody)
        
    }
    
}
