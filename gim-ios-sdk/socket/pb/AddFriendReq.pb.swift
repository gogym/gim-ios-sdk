// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: AddFriendReq.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

///指定版本，必须要写（proto3、proto2）

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct AddFriendReq {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 发送人ID
  var senderID: String = String()

  ///发送人名称
  var senderName: String = String()

  ///发送人头像URL
  var senderHeadImgURL: String = String()

  /// 接收人ID
  var receiverID: String = String()

  ///消息类型
  var msgType: Int32 = 0

  ///消息体
  var body: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension AddFriendReq: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "AddFriendReq"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "senderId"),
    2: .same(proto: "senderName"),
    3: .same(proto: "senderHeadImgUrl"),
    4: .same(proto: "receiverId"),
    5: .same(proto: "msgType"),
    6: .same(proto: "body"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.senderID)
      case 2: try decoder.decodeSingularStringField(value: &self.senderName)
      case 3: try decoder.decodeSingularStringField(value: &self.senderHeadImgURL)
      case 4: try decoder.decodeSingularStringField(value: &self.receiverID)
      case 5: try decoder.decodeSingularInt32Field(value: &self.msgType)
      case 6: try decoder.decodeSingularStringField(value: &self.body)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.senderID.isEmpty {
      try visitor.visitSingularStringField(value: self.senderID, fieldNumber: 1)
    }
    if !self.senderName.isEmpty {
      try visitor.visitSingularStringField(value: self.senderName, fieldNumber: 2)
    }
    if !self.senderHeadImgURL.isEmpty {
      try visitor.visitSingularStringField(value: self.senderHeadImgURL, fieldNumber: 3)
    }
    if !self.receiverID.isEmpty {
      try visitor.visitSingularStringField(value: self.receiverID, fieldNumber: 4)
    }
    if self.msgType != 0 {
      try visitor.visitSingularInt32Field(value: self.msgType, fieldNumber: 5)
    }
    if !self.body.isEmpty {
      try visitor.visitSingularStringField(value: self.body, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: AddFriendReq, rhs: AddFriendReq) -> Bool {
    if lhs.senderID != rhs.senderID {return false}
    if lhs.senderName != rhs.senderName {return false}
    if lhs.senderHeadImgURL != rhs.senderHeadImgURL {return false}
    if lhs.receiverID != rhs.receiverID {return false}
    if lhs.msgType != rhs.msgType {return false}
    if lhs.body != rhs.body {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
