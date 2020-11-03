import 'edible_model.dart';

class UserModel {
  final List<EdibleModel> edibles;
  final List<double> amounts;
  final List<String> dates;
  final List<double> points;
  final todayPoint;

  UserModel(
      {this.edibles, this.amounts, this.dates, this.points, this.todayPoint});

  UserModel copyWith({
    List<EdibleModel> edibles,
    List<double> amounts,
    List<String> dates,
    List<double> points,
    double todayPoint,
  }) {
    return UserModel(
        edibles: edibles ?? this.edibles,
        amounts: amounts ?? this.amounts,
        dates: dates ?? this.dates,
        points: points ?? this.points,
        todayPoint: todayPoint ?? this.todayPoint);
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        edibles: List<EdibleModel>.from(
            json["edibles"].map((x) => EdibleModel.fromJson(x))),
        amounts: List<double>.from(json["amounts"].map((x) => x)),
        dates: List<String>.from(json["dates"].map((x) => x)),
        points: List<double>.from(json["points"].map((x) => x)),
        todayPoint: json['todayPoint'],
      );

  Map<dynamic, dynamic> toJson() => {
        "edibles": List<dynamic>.from(edibles.map((x) => x.toJson())),
        "amounts": List<dynamic>.from(amounts.map((x) => x)),
        "dates": List<dynamic>.from(dates.map((x) => x)),
        "points": List<dynamic>.from(points.map((x) => x)),
        "todayPoint": todayPoint,
      };
}
