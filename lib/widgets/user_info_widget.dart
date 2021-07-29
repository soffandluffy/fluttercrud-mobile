import 'package:flutter/material.dart';
import 'package:fluttercrud/values/images.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget(
      {Key key,
      @required this.name,
      @required this.email,
      @required this.createdAt,
      this.avatarRadius,
      this.fontSize})
      : super(key: key);

  final String name;
  final String email;
  final String createdAt;
  final double avatarRadius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: avatarRadius ?? 30,
          backgroundImage: AssetImage(Images.logo),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: fontSize ?? 16, fontWeight: FontWeight.bold),
            ),
            Text(email)
          ],
        )),
        Text(createdAt)
      ],
    );
  }
}
