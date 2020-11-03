import 'package:edible/core/time/date.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/strings.dart';
import '../../../../core/error/custom_exception.dart';
import '../models/edible_model.dart';
import '../models/user_model.dart';

class EdibleLocalDataSource {
  final SharedPreferences sharedPreferences;

  EdibleLocalDataSource({this.sharedPreferences});

  Future<bool> hasUserDownloadedTheData() async {
    try {
      if (sharedPreferences.getString(Strings.isDownloaded) ==
          Strings.isDownloaded)
        return true;
      else
        return false;
    } on Exception {
      throw CustomException('Cache Failure');
    }
  }

  Future<void> setUserDownloadedTheData() async {
    try {
      sharedPreferences.setString(Strings.isDownloaded, Strings.isDownloaded);
    } on Exception {
      throw CustomException('Cache Failure');
    }
  }

  Future<void> saveEdibles(List<EdibleModel> edibles) async {
    try {
      await Hive.openBox('edibles');
      for (EdibleModel e in edibles) {
        Hive.box('edibles').add(e.toJson());
      }
    } on Exception {
      throw CustomException('Cache failure');
    }
  }

  Future<List<EdibleModel>> getEdibles() async {
    try {
      await Hive.openBox('edibles');
      List<EdibleModel> edibles = List();
      for (dynamic json in Hive.box('edibles').values) {
        EdibleModel edibleModel = EdibleModel.fromJson(json);
        edibles.add(edibleModel);
      }
      return edibles;
    } on Exception {
      throw CustomException('Cache failure');
    }
  }

  Future<UserModel> addEdible(amount, date, edibleModel, point) async {
    try {
      await Hive.openBox('user');
      UserModel newModel = UserModel.fromJson(Hive.box('user').get(0));
      newModel.amounts.add(double.parse(amount));
      newModel.dates.add(date);
      newModel.edibles.add(edibleModel);
      newModel.points.add(point);

      newModel = newModel.copyWith(todayPoint: _calculatePoint(newModel));
      final json = newModel.toJson();
      await Hive.box('user').putAt(0, json);
      return newModel;
    } on Exception {
      throw CustomException('Cache failure');
    }
  }

  Future<UserModel> getUserModel() async {
    try {
      await Hive.openBox('user');
      UserModel model = UserModel.fromJson(Hive.box('user').get(0));
      model = model.copyWith(todayPoint: _calculatePoint(model));
      final json = model.toJson();
      await Hive.box('user').putAt(0, json);
      return model;
    } on Exception {
      throw CustomException('Cache failure');
    }
  }

  double _calculatePoint(UserModel model) {
    var _temp = 0.0;
    for (int i = model.points.length - 1; i >= 0; i--) {
      if (model.dates.elementAt(i) == Today.getDate())
        _temp += model.points.elementAt(i);
      else
        break;
    }
    return _temp;
  }

  Future<UserModel> initializeUser() async {
    try {
      await Hive.openBox('user');
      UserModel model = UserModel(
        edibles: List(),
        amounts: List(),
        dates: List(),
        points: List(),
        todayPoint: 0.0,
      );
      Hive.box('user').add(model.toJson());
      sharedPreferences.setString(Strings.isSeen, Strings.isSeen);
      return model;
    } on Exception {
      throw CustomException('Cache Exception');
    }
  }
}
