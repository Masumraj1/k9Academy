class SubscriptionData {
  String? id;
  String? packageName;
  double? packagePrice;
  int? packageDuration;
  Chat? trainingVideo;
  Chat? communityGroup;
  Chat? videoLesson;
  Chat? chat;
  Chat? program;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SubscriptionData({
    this.id,
    this.packageName,
    this.packagePrice,
    this.packageDuration,
    this.trainingVideo,
    this.communityGroup,
    this.videoLesson,
    this.chat,
    this.program,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubscriptionData.fromJson(Map<String, dynamic> json) =>
      SubscriptionData(
        id: json["_id"],
        packageName: json["packageName"],
        packagePrice: json["packagePrice"]?.toDouble(),
        packageDuration: json["packageDuration"],
        trainingVideo: json["trainingVideo"] == null
            ? null
            : Chat.fromJson(json["trainingVideo"]),
        communityGroup: json["communityGroup"] == null
            ? null
            : Chat.fromJson(json["communityGroup"]),
        videoLesson: json["videoLesson"] == null
            ? null
            : Chat.fromJson(json["videoLesson"]),
        chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
        program:
            json["program"] == null ? null : Chat.fromJson(json["program"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "packageName": packageName,
        "packagePrice": packagePrice,
        "packageDuration": packageDuration,
        "trainingVideo": trainingVideo?.toJson(),
        "communityGroup": communityGroup?.toJson(),
        "videoLesson": videoLesson?.toJson(),
        "chat": chat?.toJson(),
        "program": program?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Chat {
  String? title;
  bool? status;

  Chat({
    this.title,
    this.status,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        title: json["title"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "status": status,
      };
}
