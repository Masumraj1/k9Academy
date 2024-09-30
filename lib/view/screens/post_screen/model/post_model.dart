

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  int? statusCode;
  bool? success;
  String? message;
  Meta? meta;
  List<PostData>? data;

  PostModel({
    this.statusCode,
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null ? [] : List<PostData>.from(json["data"]!.map((x) => PostData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "meta": meta?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PostData {
  String? id;
  DatumUser? user;
  String? description;
  String? image;
  List<Comment>? comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? datumId;

  PostData({
    this.id,
    this.user,
    this.description,
    this.image,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.datumId,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
    id: json["_id"],
    user: json["user"] == null ? null : DatumUser.fromJson(json["user"]),
    description: json["description"],
    image: json["image"],
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    datumId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "description": description,
    "image": image,
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "id": datumId,
  };
}

class Comment {
  CommentUser? user;
  String? content;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? commentId;

  Comment({
    this.user,
    this.content,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.commentId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    user: json["user"] == null ? null : CommentUser.fromJson(json["user"]),
    content: json["content"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    commentId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "content": content,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "id": commentId,
  };
}

class CommentUser {
  String? id;
  String? name;
  String? profileImage;
  String? userId;

  CommentUser({
    this.id,
    this.name,
    this.profileImage,
    this.userId,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) => CommentUser(
    id: json["_id"],
    name: json["name"],
    profileImage: json["profile_image"],
    userId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "profile_image": profileImage,
    "id": userId,
  };
}

class DatumUser {
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
  String? coverImage;
  DateTime? dateOfBirth;
  String? gender;
  String? verifyCode;
  DateTime? verifyExpire;
  String? userId;

  DatumUser({
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
    this.coverImage,
    this.dateOfBirth,
    this.gender,
    this.verifyCode,
    this.verifyExpire,
    this.userId,
  });

  factory DatumUser.fromJson(Map<String, dynamic> json) => DatumUser(
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
    coverImage: json["cover_image"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    gender: json["gender"],
    verifyCode: json["verifyCode"],
    verifyExpire: json["verifyExpire"] == null ? null : DateTime.parse(json["verifyExpire"]),
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
    "cover_image": coverImage,
    "date_of_birth": dateOfBirth?.toIso8601String(),
    "gender": gender,
    "verifyCode": verifyCode,
    "verifyExpire": verifyExpire?.toIso8601String(),
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






