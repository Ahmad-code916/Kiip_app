class ChatModel {
  String? chatRoomId;
  String? lastMessage;

  ChatModel({this.chatRoomId, this.lastMessage});

  ChatModel.fromMap(Map<String, dynamic> map) {
    chatRoomId = map["chatRoomId"];
    lastMessage = map["lastMessage"];
  }

  Map<String, dynamic> toMap() {
    return {
      "chatRoomId": chatRoomId,
      "lastMessage": lastMessage,
    };
  }
}
