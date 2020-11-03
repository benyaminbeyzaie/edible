import 'package:edible/constants/colors.dart';
import 'package:flutter/material.dart';

class EatenEdibleItem extends StatelessWidget {
  const EatenEdibleItem({this.name, this.amount, this.point});
  final name;
  final point;
  final amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 100,
              height: 60,
              child: Material(
                color: mainColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Center(
                  child: Text(
                    point.toStringAsFixed(2),
                    style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      name,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    amount.toString(),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
