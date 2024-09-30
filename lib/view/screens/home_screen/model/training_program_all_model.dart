import 'dart:convert';

TrainingProgramAllModel trainingProgramAllModelFromJson(String str) =>
    TrainingProgramAllModel.fromJson(json.decode(str));

String trainingProgramAllModelToJson(TrainingProgramAllModel data) =>
    json.encode(data.toJson());

class TrainingProgramAllModel {
  int? statusCode;
  bool? success;
  String? message;
  Meta? meta;
  List<TrainingProgramsData>? data;

  TrainingProgramAllModel({
    this.statusCode,
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory TrainingProgramAllModel.fromJson(Map<String, dynamic> json) =>
      TrainingProgramAllModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<TrainingProgramsData>.from(
                json["data"]!.map((x) => TrainingProgramsData.fromJson(x))),
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

class TrainingProgramsData {
  String? id;
  String? articleTitle;
  String? articleName;
  String? articleDescription;
  String? thumbnail;
  String? video;
  String? videoThumbnail;
  // String? trainingProgram;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? datumId;

  TrainingProgramsData({
    this.id,
    this.articleTitle,
    this.articleName,
    this.articleDescription,
    this.thumbnail,
    this.video,
    this.videoThumbnail,
    // this.trainingProgram,
    this.createdAt,
    this.updatedAt,
    this.datumId,
  });

  factory TrainingProgramsData.fromJson(Map<String, dynamic> json) =>
      TrainingProgramsData(
        id: json["_id"],
        articleTitle: json["article_title"],
        articleName: json["article_name"],
        articleDescription: json["article_description"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        videoThumbnail: json["video_thumbnail"],
        // trainingProgram: json["training_program"],
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
        "article_title": articleTitle,
        "article_name": articleName,
        "article_description": articleDescription,
        "thumbnail": thumbnail,
        "video": video,
        "video_thumbnail": videoThumbnail,
        //"training_program": trainingProgram,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": datumId,
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
