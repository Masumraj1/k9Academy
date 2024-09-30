// To parse this JSON data, do
//
//     final otherProfileModel = otherProfileModelFromJson(jsonString);

import 'dart:convert';

OtherProfileModel otherProfileModelFromJson(String str) =>
    OtherProfileModel.fromJson(json.decode(str));

String otherProfileModelToJson(OtherProfileModel data) =>
    json.encode(data.toJson());

class OtherProfileModel {
  int? statusCode;
  bool? success;
  String? message;
  OtherProfileData? data;

  OtherProfileModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory OtherProfileModel.fromJson(Map<String, dynamic> json) =>
      OtherProfileModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : OtherProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class OtherProfileData {
  List<Post>? posts;
  UserInfo? userInfo;

  OtherProfileData({
    this.posts,
    this.userInfo,
  });

  factory OtherProfileData.fromJson(Map<String, dynamic> json) =>
      OtherProfileData(
        posts: json["posts"] == null
            ? []
            : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
        userInfo: json["userInfo"] == null
            ? null
            : UserInfo.fromJson(json["userInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "posts": posts == null
            ? []
            : List<dynamic>.from(posts!.map((x) => x.toJson())),
        "userInfo": userInfo?.toJson(),
      };
}

class Post {
  String? id;
  String? user;
  String? description;
  String? image;
  List<Comment>? comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? postId;

  Post({
    this.id,
    this.user,
    this.description,
    this.image,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.postId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        user: json["user"],
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
        v: json["__v"],
        postId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "description": description,
        "image": image,
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "id": postId,
      };
}

class Comment {
  String? user;
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
        user: json["user"],
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
        "user": user,
        "content": content,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": commentId,
      };
}

class UserInfo {
  String? coverImage;
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? role;
  String? profileImage;
  bool? isPaid;
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
  String? userInfoId;

  UserInfo({
    this.coverImage,
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.profileImage,
    this.isPaid,
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
    this.userInfoId,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        coverImage: json["cover_image"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        role: json["role"],
        profileImage: json["profile_image"],
        isPaid: json["isPaid"],
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
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        userInfoId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "cover_image": coverImage,
        "_id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "role": role,
        "profile_image": profileImage,
        "isPaid": isPaid,
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
        "id": userInfoId,
      };
}
