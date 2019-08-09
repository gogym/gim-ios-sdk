//
//  AddFriendProtocol.swift
//  gim
//
//  Created by imac on 2019/7/8.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit


 protocol AddFriendDelegate:NSObjectProtocol {
    
    //消息处理
  func handler(message:Message,bsBody: AddFriendReq);

}
