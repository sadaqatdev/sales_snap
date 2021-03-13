import 'package:flutter/material.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';

class CustomHeading extends StatelessWidget {
  const CustomHeading({
    Key key,
    @required this.progressWidth,
    @required this.steps,
    @required this.lable,
  }) : super(key: key);

  final double progressWidth;
  final String steps;

  final String lable;

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headline2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Container(
              color: AppTheme.customColorThree,
              width: progressWidth,
              height: 4,
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                height: 4,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          steps,
          style: headingStyle.copyWith(color: AppTheme.customColorThree),
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          lable,
          style: headingStyle.copyWith(color: Colors.black),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
