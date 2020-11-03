import 'package:edible/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/edible/presentation/manager/edible_bloc.dart';
import 'injection_container.dart';

class EdibleApp extends StatelessWidget {
  final Widget starterPage;

  EdibleApp({@required this.starterPage});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<EdibleBloc>(
          create: (BuildContext context) => sl<EdibleBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Edible',
        theme: ThemeData(
          primarySwatch: mainColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          child: starterPage,
        ),
      ),
    );
  }
}
