// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';

/// This interface allows [Gesturer] to
/// use [PanZoomer] when pinching
abstract class ScaleGestureHandler {
  void start(Offset point, BuildContext context);

  void update(Offset point, double scale, BuildContext context);

  void end(BuildContext context);
}


/// This interface allows [Gesturer] to
/// use [Tapper] when tapping
abstract class TapGestureHandler {

  void tapUp(Offset point, BuildContext context);

  void tapDown(Offset point, BuildContext context);
}
