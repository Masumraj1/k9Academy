class NotificationDatum {
  String? id;
  String? user;
  String? title;
  String? message;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? datumId;

  NotificationDatum({
    this.id,
    this.user,
    this.title,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
 
    this.datumId,
  });

  factory NotificationDatum.fromJson(Map<String, dynamic> json) =>
      NotificationDatum(
        id: json["_id"],
        user: json["user"],
        title: json["title"],
        message: json["message"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
    
        datumId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "title": title,
        "message": message,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
   
        "id": datumId,
      };
}
