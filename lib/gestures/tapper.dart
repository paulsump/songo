import 'package:flutter/material.dart';
import 'package:songo/gestures/gesture_handler.dart';
import 'package:songo/out.dart';

const noWarn = out;

class Tapper implements TapGestureHandler {
  @override
  void tapDown(Offset point, BuildContext context) {
    // out(point);
  }

  @override
  void tapUp(Offset point, BuildContext context) {
    // out(point);
  }
}
