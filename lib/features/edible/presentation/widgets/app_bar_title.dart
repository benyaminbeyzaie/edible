import 'package:edible/constants/strings.dart';
import 'package:flutter/cupertino.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.edible,
      style: TextStyle(
        fontFamily: 'pacifico',
        fontSize: 26.0,
      ),
    );
  }
}
