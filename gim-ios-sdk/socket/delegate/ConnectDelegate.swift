//
//  ConnectDelegate.swift
//  gim
//
//  Created by imac on 2019/8/8.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit

protocol ConnectDelegate: NSObjectProtocol {

    func bindUserSuccess(message:Message,bsBody: ConnectResp);
}
