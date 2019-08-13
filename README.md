## gim-ios-sdk

### 这是gim在ios上使用的一个sdk，是用swift5编写的

配合gim服务器端，使用起来也是非常方便的


```
//最简单的使用示例
SocketConfig.sharedInstance.setHost(SOCKET_HOST: "localhost", SOCKET_PORT: 1234)
//开启ssl
SocketConfig.sharedInstance.openSsl(needClientAuth: true, p12Path: url, p12Passwd: "123456", cerPath: cerPath);
SocketClient.sharedInstance.startConnect();
```

### 继承简单的protocal即可实现相应功能
 SingleChatDelegate 单聊代理
 GroupChatDelegate 群聊代理
 SocketClientDelegate socket代理
 ConnectDelegate 用户绑定代理
 
 ### 业务处理器
 可根据业务自定义需要的业务处理器，如：
 
 ```
 class GroupChatHandler: AbsHandler<GroupChatReq>  {

    weak var delegate:GroupChatDelegate?
    
    override func bodyClass() -> GroupChatReq.Type {
        return GroupChatReq.self;
    }
    
    
    
    override func handler(message: Message, bsBody: GroupChatReq) {
        
        delegate?.handler(message: message, bsBody: bsBody)
        
    }
}
 ```
 
示例是一个群聊消息处理，只需实现 AbsHandler<T>  这个类即可，当然记得把处理器注册到框架里
  ```
  let groupChatHandler = GroupChatHandler();
        groupChatHandler.delegate=self;
        SocketConfig.sharedInstance.setHandler(type: Type.GROUP_MSG_REQ, handler: groupChatHandler);
  ```
  
