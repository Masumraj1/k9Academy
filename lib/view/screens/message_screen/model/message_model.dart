// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

class MessageDatum {
  String? id;
  String? sender;
  String? conversationId;
  String? image;
  String? message;
  String? messageType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? messageId;

  MessageDatum({
    this.id,
    this.sender,
    this.conversationId,
    this.image,
    this.message,
    this.messageType,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.messageId,
  });

  factory MessageDatum.fromJson(Map<String, dynamic> json) => MessageDatum(
        id: json["_id"],
        sender: json["sender"],
        conversationId: json["conversationId"],
        image: json["image"],
        message: json["message"],
        messageType: json["messageType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        messageId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender,
        "conversationId": conversationId,
        "image": image,
        "message": message,
        "messageType": messageType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "id": messageId,
      };
}

class Meta {
  int? page;
  int? limit;
  int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "totalPage": totalPage,
      };
}
