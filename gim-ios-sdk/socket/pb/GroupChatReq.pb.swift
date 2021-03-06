// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: GroupChatReq.proto
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

struct GroupChatReq {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 发送人ID
  var senderID: String = String()

  /// 群ID
  var groupID: String = String()

  ///消息类型
  var msgType: Int32 = 0

  ///消息体
  var body: String = String()

  ///需要@的人的id
  var atUserID: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension GroupChatReq: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "GroupChatReq"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "senderId"),
    2: .same(proto: "groupId"),
    3: .same(proto: "msgType"),
    4: .same(proto: "body"),
    5: .same(proto: "atUserId"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.senderID)
      case 2: try decoder.decodeSingularStringField(value: &self.groupID)
      case 3: try decoder.decodeSingularInt32Field(value: &self.msgType)
      case 4: try decoder.decodeSingularStringField(value: &self.body)
      case 5: try decoder.decodeSingularStringField(value: &self.atUserID)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.senderID.isEmpty {
      try visitor.visitSingularStringField(value: self.senderID, fieldNumber: 1)
    }
    if !self.groupID.isEmpty {
      try visitor.visitSingularStringField(value: self.groupID, fieldNumber: 2)
    }
    if self.msgType != 0 {
      try visitor.visitSingularInt32Field(value: self.msgType, fieldNumber: 3)
    }
    if !self.body.isEmpty {
      try visitor.visitSingularStringField(value: self.body, fieldNumber: 4)
    }
    if !self.atUserID.isEmpty {
      try visitor.visitSingularStringField(value: self.atUserID, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: GroupChatReq, rhs: GroupChatReq) -> Bool {
    if lhs.senderID != rhs.senderID {return false}
    if lhs.groupID != rhs.groupID {return false}
    if lhs.msgType != rhs.msgType {return false}
    if lhs.body != rhs.body {return false}
    if lhs.atUserID != rhs.atUserID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
