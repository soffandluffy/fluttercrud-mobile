import 'package:flutter/material.dart';
import 'package:fluttercrud/values/branding_color.dart';

showSnackbar(
    {@required GlobalKey<ScaffoldState> key,
    @required String message,
    Color color}) {
  ScaffoldMessenger.of(key.currentContext).showSnackBar(
    SnackBar(
      backgroundColor: color ?? brandingColor,
      content: Text(message),
    ),
  );
  // key.currentState.showSnackBar(
  //   SnackBar(
  //     backgroundColor: color ?? brandingColor,
  //     content: Text(message),
  //   ),
  // );
}
