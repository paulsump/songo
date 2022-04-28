import 'package:flutter/material.dart';
import 'package:songo/gestures/gesture_handler.dart';
import 'package:songo/out.dart';
import 'package:songo/player/sample_notifier.dart';
import 'package:songo/view/unit_to_screen.dart';

const noWarn = out;

class Tapper implements TapGestureHandler {
  @override
  void tapDown(Offset point, BuildContext context) {
    final sampleNotifier = getSampleNotifier(context, listen: false);

    sampleNotifier.kickPlayer?.play();
  }

  @override
  void tapUp(Offset point, BuildContext context) {
    // final unit = screenToUnit(point, context);
    // out(unit);
  }
}
