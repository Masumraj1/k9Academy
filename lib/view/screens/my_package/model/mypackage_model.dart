class MyPackageData {
  String? id;
  String? userId;
  PlanId? planId;
  DateTime? startDate;
  DateTime? endDate;
  String? paymentStatus;
  String? status;
  String? transactionId;
  String? amount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MyPackageData({
    this.id,
    this.userId,
    this.planId,
    this.startDate,
    this.endDate,
    this.paymentStatus,
    this.status,
    this.transactionId,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MyPackageData.fromJson(Map<String, dynamic> json) => MyPackageData(
        id: json["_id"],
        userId: json["user_id"],
        planId:
            json["plan_id"] == null ? null : PlanId.fromJson(json["plan_id"]),
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        paymentStatus: json["payment_status"],
        status: json["status"],
        transactionId: json["transaction_id"],
        amount: json["amount"],
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
        "user_id": userId,
        "plan_id": planId?.toJson(),
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "payment_status": paymentStatus,
        "status": status,
        "transaction_id": transactionId,
        "amount": amount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class PlanId {
  String? id;
  String? packageName;
  double? packagePrice;
  int? packageDuration;
  Chat? trainingVideo;
  Chat? communityGroup;
  Chat? videoLesson;
  Chat? chat;
  Chat? program;

  PlanId({
    this.id,
    this.packageName,
    this.packagePrice,
    this.packageDuration,
    this.trainingVideo,
    this.communityGroup,
    this.videoLesson,
    this.chat,
    this.program,
  });

  factory PlanId.fromJson(Map<String, dynamic> json) => PlanId(
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
