import 'package:edible/constants/colors.dart';
import 'package:flutter/material.dart';

class AddFloatingActionButton extends StatelessWidget {
  final onPressed;
  const AddFloatingActionButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(
        Icons.add,
        color: onBackgroundColor,
      ),
    );
  }
}
