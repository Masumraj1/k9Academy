

import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  int? statusCode;
  bool? success;
  String? message;
  Meta? meta;
  List<ScheduleData>? data;

  ScheduleModel({
    this.statusCode,
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null ? [] : List<ScheduleData>.from(json["data"]!.map((x) => ScheduleData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "meta": meta?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ScheduleData {
  String? id;
  List<User>? users;
  String? meetLink;
  DateTime? date;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? datumId;

  ScheduleData({
    this.id,
    this.users,
    this.meetLink,
    this.date,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.datumId,
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) => ScheduleData(
    id: json["_id"],
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    meetLink: json["meet_link"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    password: json["password"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    datumId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    "meet_link": meetLink,
    "date": date?.toIso8601String(),
    "password": password,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "id": datumId,
  };
}

class User {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? role;
  String? profileImage;
  String? activationCode;
  bool? isBlock;
  bool? isActive;
  String? planType;
  DateTime? expirationTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? age;
  DateTime? dateOfBirth;
  String? gender;
  String? userId;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.profileImage,
    this.activationCode,
    this.isBlock,
    this.isActive,
    this.planType,
    this.expirationTime,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.age,
    this.dateOfBirth,
    this.gender,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    role: json["role"],
    profileImage: json["profile_image"],
    activationCode: json["activationCode"],
    isBlock: json["is_block"],
    isActive: json["isActive"],
    planType: json["plan_type"],
    expirationTime: json["expirationTime"] == null ? null : DateTime.parse(json["expirationTime"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    age: json["age"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    gender: json["gender"],
    userId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "role": role,
    "profile_image": profileImage,
    "activationCode": activationCode,
    "is_block": isBlock,
    "isActive": isActive,
    "plan_type": planType,
    "expirationTime": expirationTime?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "age": age,
    "date_of_birth": dateOfBirth?.toIso8601String(),
    "gender": gender,
    "id": userId,
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}
