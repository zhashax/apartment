// To parse this JSON data, do
//
//     final objectsModel = objectsModelFromJson(jsonString);

import 'dart:convert';

ObjectsModel objectsModelFromJson(String str) => ObjectsModel.fromJson(json.decode(str));

String objectsModelToJson(ObjectsModel data) => json.encode(data.toJson());

class ObjectsModel {
  ObjectsModel({
    required this.success,
    required this.data,
    this.message,
    required this.statusCode,
  });

  bool success;
  List<Datum> data;
  dynamic message;
  int statusCode;

  factory ObjectsModel.fromJson(Map<String, dynamic> json) => ObjectsModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status_code": statusCode,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.userId,
    required this.title,
    required this.area,
    required this.cost1M,
    required this.costRent,
    required this.fullAddress,
    required this.longitude,
    required this.latitude,
    required this.city,
    required this.street,
    required this.premiseNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  }) {
    // TODO: implement
    throw UnimplementedError();
  }

  int id;
  int userId;
  String title;
  String area;
  String cost1M;
  String costRent;
  String fullAddress;
  String longitude;
  String latitude;
  String city;
  String street;
  String premiseNumber;
  DateTime createdAt;
  DateTime updatedAt;
  List<Image> images;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    area: json["area"],
    cost1M: json["cost_1m"],
    costRent: json["cost_rent"],
    fullAddress: json["full_address"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    city: json["city"],
    street: json["street"],
    premiseNumber: json["premiseNumber"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "area": area,
    "cost_1m": cost1M,
    "cost_rent": costRent,
    "full_address": fullAddress,
    "longitude": longitude,
    "latitude": latitude,
    "city": city,
    "street": street,
    "premiseNumber": premiseNumber,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
}

class Image {
  Image({
    required this.id,
    required this.objectId,
    required this.imagePath,
    required this.imageName,
  });

  int id;
  int objectId;
  String imagePath;
  String imageName;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    objectId: json["object_id"],
    imagePath: json["image_path"],
    imageName: json["image_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object_id": objectId,
    "image_path": imagePath,
    "image_name": imageName,
  };
}
