import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MediaModel? medialModel;
  String? id;
  String? message;
  DateTime? messageTime;
  String? senderId;
  String? threadId;
  int? messageType;
  List<dynamic>? participantUserList;

  MessageModel({
    required this.medialModel,
    required this.id,
    required this.message,
    required this.messageTime,
    required this.senderId,
    required this.threadId,
    required this.messageType,
    required this.participantUserList,
  });

  MessageModel.fromMap(Map<String, dynamic> map) {
    id = map["id"] ?? "";
    medialModel =
        map['media'] != null ? MediaModel.fromMap(map['media']) : null;
    message = map["message"] ?? "";
    messageTime = (map["messageTime"] as Timestamp).toDate();
    senderId = map["senderId"] ?? "";
    threadId = map["threadId"] ?? "";
    messageType = map["messageType"] ?? 0;
    participantUserList = map["participantUserList"];
  }

  Map<String, dynamic> toMap() {
    return {
      "media": medialModel?.toMap(),
      "id": id,
      "message": message,
      "messageTime": Timestamp.fromDate(messageTime!),
      "senderId": senderId,
      "threadId": threadId,
      "messageType": messageType,
      "participantUserList": participantUserList,
    };
  }
}

class MediaModel {
  final String id;
  final int type;
  final String? thumbnail;
  final String url;
  final DateTime createdAt;
  final String name;

  MediaModel({
    required this.type,
    this.thumbnail,
    required this.id,
    required this.url,
    required this.createdAt,
    required this.name,
  });

  MediaModel copyWith({
    String? id,
    int? type,
    String? thumbnail,
    String? url,
    DateTime? createdAt,
    String? name,
  }) {
    return MediaModel(
      id: id ?? this.id,
      type: type ?? this.type,
      thumbnail: thumbnail ?? this.thumbnail,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'thumbnail': thumbnail,
      'type': type,
      'createdAt': Timestamp.fromDate(createdAt),
      'name': name,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      id: map['id'] as String,
      url: map['url'] as String,
      thumbnail: map['thumbnail'] ?? "",
      type: map['type'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      name: map['name'] as String,
    );
  }

  @override
  String toString() {
    return 'MediaModel(thumbnail: $thumbnail, type: $type, id: $id, url: $url, createdAt: $createdAt, name: $name)';
  }
}
