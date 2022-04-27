// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songo/gestures/pan_zoom.dart';
import 'package:songo/out.dart';
import 'package:songo/view/hue.dart';
import 'package:songo/view/main_page.dart';
import 'package:songo/view/screen_adjust.dart';

/// prevent 'organise imports' from removing imports
/// when temporarily commenting out.
const noWarn = [out, unawaited];

void main() => runApp(createApp());

Widget createApp() => const TheApp();

/// The only App in this app.
class TheApp extends StatelessWidget {
  const TheApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PanZoomNotifier()),
      ],
      child: MaterialApp(
        theme: _buildThemeData(context),
        home: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxHeight == 0) {
              return Container();
            } else {
              final panZoomNotifier =
                  getPanZoomNotifier(context, listen: false);

              // Initialize once only
              if (panZoomNotifier.scale == 0) {
                panZoomNotifier.initializeScale(screenAdjust(0.7, context));

              }
              // final
              return WillPopScope(
                onWillPop: () async => false,
                child: const MainPage(),
              );
            }
          },
        ),
      ),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
      canvasColor: Hue.menu,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: Hue.text),
      // for icon buttons only atm
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: Hue.enabledIcon,
          ),
      tooltipTheme: TooltipThemeData(
        /// TODO Responsive to screen size - removed magic numbers
        verticalOffset: 55,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Hue.tip),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: Hue.button,
      )),
    );
  }
}
