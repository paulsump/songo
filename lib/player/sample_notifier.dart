// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songo/out.dart';
import 'package:songo/player/samples.dart';

const noWarn = out;

SampleNotifier getSampleNotifier(BuildContext context,
        {required bool listen}) =>
    Provider.of<SampleNotifier>(context, listen: listen);

/// Access to prepared songs
class SampleNotifier with ChangeNotifier {
  final _instruments = <String, Instrument>{
    // 'Piano': Piano(),
    'Kick': Kick(),
    // 'Bass': Bass(),
    // 'Arp': Arp(),
  };

  // TODO REMOVE KICK HACK
  Player? kickPlayer;

  Future<void> preLoad() async {
    for (final Instrument instrument in _instruments.values) {
      await instrument.preLoad();

      // TODO REMOVE KICK HACK
      kickPlayer = Player(audioPlayer: _instruments['Kick']!.getPlayer(1, 1));
    }

    notifyListeners();
  }
}

/// Play a sample.
class Player {
  Player({required this.audioPlayer});

  final AudioPlayer audioPlayer;

  bool get _sampleIsAlreadyPlaying => audioPlayer.state == PlayerState.PLAYING;

  void play() {
    if (_sampleIsAlreadyPlaying) {
      // Go back to start (instead of seek(0) which isn't allowed with LOW_LATENCY).
      unawaited(audioPlayer.stop());
    }

    unawaited(audioPlayer.resume());
  }

  void stop() {
    unawaited(audioPlayer.stop());
  }
}
