// To parse this JSON data, do
//
//     final traningProgramsModel = traningProgramsModelFromJson(jsonString);

import 'dart:convert';

TraningProgramsModel traningProgramsModelFromJson(String str) =>
    TraningProgramsModel.fromJson(json.decode(str));

String traningProgramsModelToJson(TraningProgramsModel data) =>
    json.encode(data.toJson());

class TraningProgramsModel {
  int? statusCode;
  bool? success;
  String? message;
  Meta? meta;
  List<TrainingDatum>? data;

  TraningProgramsModel({
    this.statusCode,
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory TraningProgramsModel.fromJson(Map<String, dynamic> json) =>
      TraningProgramsModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null
            ? []
            : List<TrainingDatum>.from(
                json["data"]!.map((x) => TrainingDatum.fromJson(x))),
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

class TrainingDatum {
  String? id;
  String? title;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? datumId;

  TrainingDatum({
    this.id,
    this.title,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.datumId,
  });

  factory TrainingDatum.fromJson(Map<String, dynamic> json) => TrainingDatum(
        id: json["_id"],
        title: json["title"],
        image: json["image"],
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
        "title": title,
        "image": image,
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
