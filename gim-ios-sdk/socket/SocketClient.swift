//
//  SocketClient.swift
//  BestTravel
//
//  Created by gj on 16/11/1.
//
//

import UIKit
import SwiftProtobuf

class SocketClient: NSObject{
    
    weak var delegate:SocketClientDelegate?
    
    fileprivate var clientSocket: GCDAsyncSocket!
    //数据缓冲
    fileprivate var receiveData:Data=Data.init();
    //创建监听类
    fileprivate var baseHanlder=BaseHandler();
    
    
    //重连时间间隔
    fileprivate var timeInterval=1;
    
    
    //单例模式
    static let sharedInstance=SocketClient();
    private override init() {
        super.init();
        clientSocket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
    }
    
    
}

extension SocketClient {
    // 开始连接
    func startConnect(){
        startReConnectTimer();
    }
    
    //断开连接
    func stopConnect(){
        if(clientSocket.isConnected){
            clientSocket.disconnect()
        }
    }
    
    
    //启动连接定时器
    func startReConnectTimer(){
        
        if(self.clientSocket.isDisconnected){
            //启动一个定时器执行
            GCDTimer.share.scheduledDispatchTimer(withName: "reconnect",firstTime:Double(timeInterval) , timeInterval: Double(timeInterval), queue: .main, repeats: false) {
                print("重连中...")
                
                if(self.timeInterval<30){
                    //每次从连增加3秒的间隔时间,步长越来越长
                    self.timeInterval+=3;
                }
                
                do {
                    try self.clientSocket.connect(toHost: SocketConfig.sharedInstance.getHost(), onPort: UInt16(SocketConfig.sharedInstance.getPort()), withTimeout: -1)
                } catch {
                    print(error)
                }
            }
        }
        
    }
    
    //停止连接定时器
    func stopReConnectTimer(){
        GCDTimer.share.destoryTimer(withName: "reconnect");
    }
    
}

extension SocketClient{
    
    //发送消息
    func sendMessage(msg:Data){
        
        clientSocket.write(msg, withTimeout: -1, tag: 1)
        clientSocket.readData(withTimeout: -1, tag: 0)
    }
    
    
    func getSecIdentity()-> SecIdentity{
        
        //let bundle = Bundle(for: SocketClient.self)
        
        //        guard let url = bundle.url(forResource: "clientStore", withExtension: "p12",subdirectory: "res") else {
        //            fatalError("Missing the server cert resource from the bundle")
        //        }
        
        let url = SocketConfig.sharedInstance.getP12();
        let passwd=SocketConfig.sharedInstance.getP12Passwd();
        
        do {
            let p12 = try Data(contentsOf: url!) as CFData
            let options = [kSecImportExportPassphrase as String: passwd!] as CFDictionary
            
            var rawItems: CFArray?
            
            guard SecPKCS12Import(p12, options, &rawItems) == errSecSuccess else {
                fatalError("Error in p12 import")
            }
            
            let items = rawItems as! Array<Dictionary<String,Any>>
            let identity = items[0][kSecImportItemIdentity as String] as! SecIdentity
            
            return identity;
        }
        catch {
            fatalError("Could not create server certificate")
        }
        
        
    }
}



//MARK: 监听
extension SocketClient: GCDAsyncSocketDelegate {
    
    // 断开连接
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let strNowTime = timeFormatter.string(from: date) as String
        print(strNowTime)
        
        //连接断开后停止心跳
        HeartBeatHandler.heartBeatHandler.stopHeartBeat();
        //启动重连
        startReConnectTimer();
        
        delegate?.didDisconnect(err: err);
        
    }
    
    // 连接成功
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        let address = "服务器IP：" + "\(host)"
        print(address)
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let strNowTime = timeFormatter.string(from: date) as String
        print(strNowTime)
        
        if(SocketConfig.sharedInstance.getSsl()){
            var settings: [String: NSObject]
            
            settings = [
                kCFStreamSSLIsServer as String: NSNumber(value: false),
                GCDAsyncSocketManuallyEvaluateTrust as String: NSNumber(value: true),
            ]
            
            if(SocketConfig.sharedInstance.getNeedClientAuth()){
                settings[kCFStreamSSLCertificates as String] = NSArray(array: [getSecIdentity()]);
            }
            sock.startTLS(settings)
        }
        
        
        
        
        
        //连接成功后，停止重连定时器
        stopReConnectTimer();
        //启动心跳机制
        HeartBeatHandler.heartBeatHandler.startHeartBeat(socket: sock);
        
        delegate?.didConnect(host: host);
        
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    
    func socket(_ sock: GCDAsyncSocket, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        
        if(SocketConfig.sharedInstance.getNeedClientAuth()){
            //let bundle = Bundle(for: SocketClient.self)
            
            //            guard let url = bundle.url(forResource: "server", withExtension: "cer",subdirectory: "res") else {
            //                fatalError("Missing the server cert resource from the bundle")
            //            }
            
            let url=SocketConfig.sharedInstance.getCer();
            
            
            do {
                let rootCertData = try Data(contentsOf: url!)
                
                var status:OSStatus = -1;
                
                var result:SecTrustResultType = .deny;
                
                
                // if(rootCertData != nil) {
                
                // 创建信任证书
                
                let certData = CFBridgingRetain(rootCertData)
                
                var cert1: SecCertificate?
                
                cert1 = SecCertificateCreateWithData(nil, certData as! CFData)
                
                // 设置信任证书
                SecTrustSetAnchorCertificates(trust, [cert1] as CFArray)
                
                
                
                status = SecTrustEvaluate(trust, &result)
                
                //                } else {
                //
                //                    print("local certificates could not be loaded");
                //
                //                    completionHandler(false);
                //
                //                }
                
                
                if status == 0 && (result == .proceed || result == .unspecified) {
                    
                    //成功通过验证，证书可信
                    
                    print("local certificates is trust")
                    
                    completionHandler(true);
                } else {
                    
                    let arrayRefTrust = SecTrustCopyProperties(trust)
                    
                    print("error in connection occured\n\(String(describing: arrayRefTrust))")
                    
                    completionHandler(false);
                }
                
            } catch {
                fatalError("Could not create server certificate")
            }
        }else{
            completionHandler(true)
        }
        
        
        
        
        
        
    }
    
    
    func socketDidSecure(_ sock: GCDAsyncSocket) {
        delegate?.didSecure();
    }
    
    
    // 接收到消息
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        
        self.receiveData.append(data);
        
        //读取data的头部占用字节 和 从头部读取内容长度
        //验证结果：数据比较小时头部占用字节为1，数据比较大时头部占用字节为2
        var headL:Int  = 0;
        let contentL:Int32 = try! ReadRawVarint32Decode.readRawVarint32(buffer: [UInt8](data), bufferPos: &headL)
        
        
        if (contentL < 1){
            sock.readData(withTimeout: -1, tag: 0);
            return;
        }
        
        //拆包情况下：继续接收下一条消息，直至接收完这条消息所有的拆包，再解析
        if (Int32(headL) + contentL > self.receiveData.count){
            sock.readData(withTimeout: -1, tag: 0);
            return;
        }
        
        //当receiveData长度不小于第一条消息内容长度时，开始解析receiveData
        self.parseContentData(headL: Int32(headL), contentL: contentL);
        sock.readData(withTimeout: -1, tag: 0);
    }
    
    
    
    //-----------------------------------------------------------------------------------------------
    
    
    /** 解析二进制数据：NSData --> 自定义模型对象 */
    func parseContentData( headL: Int32, contentL: Int32) {
        //        var headL = headL
        //        var contentL = contentL
        
        let range = Range(0...Int(headL + contentL-1)) //本次解析data的范围
        let data = receiveData.subdata(in: range) //本次解析的data
        
        do {
            
            let stream = InputStream.init(data: data);
            stream.open()
            var message = Message();
            try BinaryDelimited.merge(into:&message, from: stream)
            stream.close();
            
            //处理消息
            baseHanlder.read(message: message)
            
            //移除已经解析过的data
            receiveData.removeSubrange(range)
            if (receiveData.count < 1) {
                return
            }
            
            //对于粘包情况下被合并的多条消息，循环递归直至解析完所有消息
            var headL:Int = 0
            let contentL = try ReadRawVarint32Decode.readRawVarint32(buffer: [UInt8](receiveData), bufferPos: &headL)
            if headL + Int(contentL) > receiveData.count {
                return //实际包不足解析，继续接收下一个包
            }
            
        } catch  {
            
            print(error)
        }
        
        parseContentData(headL: headL, contentL: contentL) //继续解析下一条
    }
    
    
    
}
