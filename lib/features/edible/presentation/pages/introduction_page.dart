import 'package:edible/features/edible/presentation/manager/edible_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../constants/numbers.dart';
import '../../../../constants/strings.dart';
import 'home_page.dart';

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    BlocProvider.of<EdibleBloc>(context).add(CreateInitializeUserEvent());
    super.initState();
  }

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(
        assetName,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        key: introKey,
        pages: [
          PageViewModel(
            title: Strings.headerOne,
            body: Strings.introBodyOne,
            image: _buildImage('images/intro_1.jpg'),
            decoration: PageDecoration(
              pageColor: Colors.white,
              imagePadding: EdgeInsets.all(24.0),
            ),
          ),
          PageViewModel(
            title: Strings.headerTwo,
            body: Strings.introBodyTwo,
            image: _buildImage('images/intro_2.jpg'),
            decoration: PageDecoration(
              pageColor: Colors.white,
              imagePadding: EdgeInsets.all(24.0),
            ),
          ),
        ],
        onDone: () => _onIntroEnd(context),
        skipFlex: 0,
        nextFlex: 0,
        done: Text(
          Strings.start,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: k18),
        ),
      ),
    );
  }
}
