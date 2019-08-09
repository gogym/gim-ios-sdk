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
