//
//  SocketConfig.swift
//  gim
//
//  Created by imac on 2019/7/8.
//  Copyright © 2019 gim. All rights reserved.
//

import UIKit
import SwiftProtobuf

class SocketConfig: NSObject {

    fileprivate var handlerDict = Dictionary<Int,ChatBsProtocol>();
    
    //是否开启ssl
    var isSsl:Bool=false;
    var needClientAuth=false;
    var p12Path:URL?;
    var cerPath:URL?;
    var p12Passwd:String?;
    var cerPasswd:String?;
    
    //单例模式
    static let sharedInstance=SocketConfig();
    private override init() {
        super.init();
        
        //handlerDict[Type.CONNET_RESP]=ConnetHandler();
        handlerDict[Type.ACK_REQ]=AckHandler();
        //handlerDict[Type.ADD_FRIEND_REQ]=AddFriendHandler();
        //handlerDict[Type.ADD_FRIEND_RESP]=AddFriendRespHandler();
    }
    
    
    func setHandler(type:Int,handler:ChatBsProtocol){
        handlerDict[type]=handler;
    }
    
    
    func getHandler(type:Int)->ChatBsProtocol?{
        return handlerDict[type];
    }
    
    
    func openSsl(needClientAuth:Bool,p12Path:URL?,p12Passwd:String,cerPath:URL?){
        self.isSsl=true;
        self.needClientAuth=needClientAuth;
        
        if(needClientAuth){
            if(p12Path==nil || cerPath==nil){
                  fatalError("Missing the server cert resource from the bundle")
            }else{
                self.p12Path=p12Path;
                self.cerPath=cerPath;
                
                self.p12Passwd=p12Passwd;
                
            }
        }
    }
    
    
    func getSsl() -> Bool {
        return self.isSsl;
    }
    
    func getNeedClientAuth() -> Bool {
        return self.needClientAuth;
    }
    
    func getP12()->URL?{
        return self.p12Path;
    }
    
    func getCer() -> URL? {
        return self.cerPath;
    }
    
    func getP12Passwd()->String?{
        return self.p12Passwd;
    }
    
    func getCerPasswd()->String?{
        
        return self.cerPasswd;
    }
}
