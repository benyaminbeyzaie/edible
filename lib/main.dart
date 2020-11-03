import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/strings.dart';
import 'edible_app.dart';
import 'features/edible/data/models/user_model.dart';
import 'features/edible/presentation/manager/edible_bloc.dart';
import 'features/edible/presentation/pages/home_page.dart';
import 'features/edible/presentation/pages/introduction_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(EdibleApp(starterPage: await _start()));
}

Future<Widget> _start() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.get(Strings.isSeen) == Strings.isSeen)
    return HomePage();

  return IntroductionPage();
}
