// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:songo/gestures/gesture_handler.dart';
import 'package:songo/gestures/pan_zoom.dart';
import 'package:songo/gestures/tapper.dart';

/// Handle gestures, passing them to [PanZoomer].
///
/// Stateful because of mutable fields.
class Gesturer extends StatefulWidget {
  const Gesturer({Key? key}) : super(key: key);

  @override
  State<Gesturer> createState() => GesturerState();
}

class GesturerState extends State<Gesturer> {
  final ScaleGestureHandler panZoomer = PanZoomer();

  final TapGestureHandler tapper = Tapper();

  bool tapped = false;
  Offset tapPoint = Offset.zero;

  int n = 0;
  double totalScale = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onScaleStart: (details) {
        n = 0;
        totalScale = 0;

        panZoomer.start(details.focalPoint, context);
      },
      onScaleUpdate: (details) {
        n++;

        totalScale += details.scale;

        panZoomer.update(details.focalPoint, details.scale, context);
      },
      onScaleEnd: (details) {
        tapped = false;
        panZoomer.end(context);
      },
      onTapDown: (details) {
        tapped = true;

        tapPoint = details.localPosition;
        tapper.tapDown(tapPoint, context);
      },
      onTapUp: (details) {
        tapped = false;

        tapper.tapUp(details.localPosition, context);
      },
    );
  }
}
