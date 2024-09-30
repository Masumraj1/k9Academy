// To parse this JSON data, do
//
//     final traningDetailsModel = traningDetailsModelFromJson(jsonString);

import 'dart:convert';

TraningDetailsModel traningDetailsModelFromJson(String str) =>
    TraningDetailsModel.fromJson(json.decode(str));

String traningDetailsModelToJson(TraningDetailsModel data) =>
    json.encode(data.toJson());

class TraningDetailsModel {
  int? statusCode;
  bool? success;
  String? message;
  List<TrainingDetailsDatum>? data;

  TraningDetailsModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory TraningDetailsModel.fromJson(Map<String, dynamic> json) =>
      TraningDetailsModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TrainingDetailsDatum>.from(
                json["data"]!.map((x) => TrainingDetailsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TrainingDetailsDatum {
  String? id;
  String? articleTitle;
  String? articleName;
  String? articleDescription;
  String? thumbnail;
  String? video;

  String? trainingProgram;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? datumId;

  TrainingDetailsDatum({
    this.id,
    this.articleTitle,
    this.articleName,
    this.articleDescription,
    this.thumbnail,
    this.video,
    this.trainingProgram,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.datumId,
  });

  factory TrainingDetailsDatum.fromJson(Map<String, dynamic> json) =>
      TrainingDetailsDatum(
        id: json["_id"],
        articleTitle: json["article_title"],
        articleName: json["article_name"],
        articleDescription: json["article_description"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        trainingProgram: json["training_program"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        datumId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "article_title": articleTitle,
        "article_name": articleName,
        "article_description": articleDescription,
        "thumbnail": thumbnail,
        "video": video,
        // "video_thumbnail": videoThumbnail,
        "training_program": trainingProgram,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "id": datumId,
      };
}
