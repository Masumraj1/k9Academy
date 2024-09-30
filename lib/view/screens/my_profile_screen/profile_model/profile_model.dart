class ProfileModel {
  int? statusCode;
  bool? success;
  String? message;
  DataModel? data;

  ProfileModel({this.statusCode, this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataModel {
  UserInfo? userInfo;
  List<dynamic>? posts;
  List<dynamic>? schedule;

  DataModel({this.userInfo, this.posts, this.schedule});

  DataModel.fromJson(Map<String, dynamic> json) {
    userInfo =
        json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
    posts = json['posts'] != null ? List<dynamic>.from(json['posts']) : [];
    schedule =
        json['schedule'] != null ? List<dynamic>.from(json['schedule']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data['userInfo'] = userInfo!.toJson();
    }
    if (posts != null) {
      data['posts'] = posts;
    }
    if (schedule != null) {
      data['schedule'] = schedule;
    }
    return data;
  }
}

class UserInfo {
  String? sId;
  String? name;
  String? email;
  String? age;
  String? dateOfBirth;
  String? gender;
  String? phoneNumber;
  String? role;
  String? profileImage;
  String? coverImage;

  String? activationCode;
  bool? isBlock;
  bool? isActive;
  String? planType;
  String? expirationTime;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;

  UserInfo({
    this.sId,
    this.name,
    this.email,
    this.age,
    this.dateOfBirth,
    this.gender,
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
    this.iV,
    this.id,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    age = json['age'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    role = json['role'];
    profileImage = json['profile_image'];
    coverImage = json['cover_image'];

    activationCode = json['activationCode'];
    isBlock = json['is_block'];
    isActive = json['isActive'];
    planType = json['plan_type'];
    expirationTime = json['expirationTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['age'] = age;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    data['role'] = role;
    data['profile_image'] = profileImage;
    data['cover_image'] = coverImage;

    data['activationCode'] = activationCode;
    data['is_block'] = isBlock;
    data['isActive'] = isActive;
    data['plan_type'] = planType;
    data['expirationTime'] = expirationTime;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['id'] = id;
    return data;
  }
}
