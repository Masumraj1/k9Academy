// To parse this JSON data, do
//
//     final communityPostModel = communityPostModelFromJson(jsonString);

import 'dart:convert';

CommunityPostModel communityPostModelFromJson(String str) =>
    CommunityPostModel.fromJson(json.decode(str));

String communityPostModelToJson(CommunityPostModel data) =>
    json.encode(data.toJson());

class CommunityPostModel {
  int? statusCode;
  bool? success;
  String? message;
  Meta? meta;
  List<CommunityDatum>? data;

  CommunityPostModel({
    this.statusCode,
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory CommunityPostModel.fromJson(Map<String, dynamic> json) =>
      CommunityPostModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<CommunityDatum>.from(
                json["data"]!.map((x) => CommunityDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "meta": meta?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CommunityDatum {
  String? id;
  DatumUser? user;
  String? description;
  String? image;
  List<Comment>? comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? datumId;

  CommunityDatum({
    this.id,
    this.user,
    this.description,
    this.image,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.datumId,
  });

  factory CommunityDatum.fromJson(Map<String, dynamic> json) => CommunityDatum(
        id: json["_id"],
        user: json["user"] == null ? null : DatumUser.fromJson(json["user"]),
        description: json["description"],
        image: json["image"],
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
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
        "user": user?.toJson(),
        "description": description,
        "image": image,
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
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
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
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
  String? profileImage;
  String? id;
  String? name;
  String? userId;

  CommentUser({
    this.profileImage,
    this.id,
    this.name,
    this.userId,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) => CommentUser(
        profileImage: json["profile_image"],
        id: json["_id"],
        name: json["name"],
        userId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "profile_image": profileImage,
        "_id": id,
        "name": name,
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
  String? coverImage;
  String? activationCode;
  bool? isBlock;
  bool? isActive;
  String? planType;
  DateTime? expirationTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? age;
  String? userId;

  DatumUser({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.profileImage,
    this.coverImage,
    this.activationCode,
    this.isBlock,
    this.isActive,
    this.planType,
    this.expirationTime,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.age,
    this.userId,
  });

  factory DatumUser.fromJson(Map<String, dynamic> json) => DatumUser(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        role: json["role"],
        profileImage: json["profile_image"],
        coverImage: json["cover_Image"],
        activationCode: json["activationCode"],
        isBlock: json["is_block"],
        isActive: json["isActive"],
        planType: json["plan_type"],
        expirationTime: json["expirationTime"] == null
            ? null
            : DateTime.parse(json["expirationTime"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        age: json["age"],
        userId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "role": role,
        "profile_image": profileImage,
        "cover_image": coverImage,
        "activationCode": activationCode,
        "is_block": isBlock,
        "isActive": isActive,
        "plan_type": planType,
        "expirationTime": expirationTime?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "age": age,
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
