//
//  SingleChatDelegate.swift
//  gim
//
//  Created by imac on 2019/7/11.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit

protocol SingleChatDelegate: NSObjectProtocol {

    
    //消息处理
    func handler(message:Message,bsBody: SingleChatReq);

}
