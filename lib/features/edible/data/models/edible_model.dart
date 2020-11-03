// To parse this JSON data, do
//
//     final nutritionalData = nutritionalDataFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

EdibleModel edibleModelFromJson(String str) =>
    EdibleModel.fromJson(json.decode(str));

String edibleModelToJson(EdibleModel data) => json.encode(data.toJson());

class EdibleModel extends Equatable {
  EdibleModel({
    this.token,
    this.name,
    this.aliases,
    this.aliasesString,
    this.units,
    this.smallestSteps,
    this.nutritionalData,
    this.pointsPerSmallestSteps,
    this.isVerified,
    this.isCustom,
    this.isZeroPoints,
    this.barcode,
  });

  final String token;
  final String name;
  final List<String> aliases;
  final String aliasesString;
  final List<String> units;
  final List<int> smallestSteps;
  final List<Map<String, NutritionalDatum>> nutritionalData;
  final List<double> pointsPerSmallestSteps;
  final bool isVerified;
  final bool isCustom;
  final bool isZeroPoints;
  final dynamic barcode;

  factory EdibleModel.fromJson(Map<dynamic, dynamic> json) => EdibleModel(
        token: json["token"],
        name: json["name"],
        aliases: List<String>.from(json["aliases"].map((x) => x)),
        aliasesString: json["aliasesString"],
        units: List<String>.from(json["units"].map((x) => x)),
        smallestSteps: List<int>.from(json["smallestSteps"].map((x) => x)),
        nutritionalData: List<Map<String, NutritionalDatum>>.from(
            json["nutritionalData"].map((x) => Map.from(x).map((k, v) =>
                MapEntry<String, NutritionalDatum>(
                    k, NutritionalDatum.fromJson(v))))),
        pointsPerSmallestSteps: List<double>.from(
            json["pointsPerSmallestSteps"].map((x) => x.toDouble())),
        isVerified: json["isVerified"],
        isCustom: json["isCustom"],
        isZeroPoints: json["isZeroPoints"],
        barcode: json["barcode"],
      );

  Map<dynamic, dynamic> toJson() => {
        "token": token,
        "name": name,
        "aliases": List<dynamic>.from(aliases.map((x) => x)),
        "aliasesString": aliasesString,
        "units": List<dynamic>.from(units.map((x) => x)),
        "smallestSteps": List<dynamic>.from(smallestSteps.map((x) => x)),
        "nutritionalData": List<dynamic>.from(nutritionalData.map((x) =>
            Map.from(x)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))),
        "pointsPerSmallestSteps":
            List<dynamic>.from(pointsPerSmallestSteps.map((x) => x)),
        "isVerified": isVerified,
        "isCustom": isCustom,
        "isZeroPoints": isZeroPoints,
        "barcode": barcode,
      };

  @override
  List<Object> get props => [token];
}

class NutritionalDatum {
  NutritionalDatum({
    this.value,
    this.identifier,
  });

  final double value;
  final int identifier;

  factory NutritionalDatum.fromJson(Map<dynamic, dynamic> json) =>
      NutritionalDatum(
        value: json["value"].toDouble(),
        identifier: json["identifier"],
      );

  Map<dynamic, dynamic> toJson() => {
        "value": value,
        "identifier": identifier,
      };
}
