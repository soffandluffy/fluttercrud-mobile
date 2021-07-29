import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class OpportunityLinksWidget extends StatelessWidget {
  const OpportunityLinksWidget(
      {Key key,
      @required this.categoryName,
      @required this.views,
      @required this.deadline})
      : super(key: key);

  final String categoryName;
  final String views;
  final String deadline;
  @override
  Widget build(BuildContext context) {
    TextStyle _iconTextStyle =
        TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    double _iconSize = 20;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Icon(
                Icons.school,
                size: _iconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "$categoryName",
                style: _iconTextStyle,
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.remove_red_eye,
              size: _iconSize,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "$views",
              style: _iconTextStyle,
            )
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Icon(
                Icons.share,
                size: _iconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Share", style: _iconTextStyle)
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.event,
              size: _iconSize,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "$deadline",
              style: _iconTextStyle,
            )
          ],
        ),
      ],
    );
  }
}
