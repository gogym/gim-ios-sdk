//
//  SocketClientDelegate.swift
//  gim
//
//  Created by imac on 2019/8/8.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit

protocol SocketClientDelegate: NSObjectProtocol {

    
    func didConnect(host:String);
    
    func didDisconnect(err: Error?);
    
    func didSecure();
    
}
