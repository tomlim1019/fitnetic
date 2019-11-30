import 'package:flutter/material.dart';
import 'package:fitnetic/constant.dart';
class ReusableCardContent extends StatelessWidget {
  ReusableCardContent({@required this.icon, @required this.label, @required this.color});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80,
          color: color,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          label,
          style: kLabelTextStyle
        )
      ],
    );
  }
}