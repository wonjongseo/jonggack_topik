import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';

enum SoundOptions {
  speedRate(Colors.redAccent),
  volumn(Colors.blueAccent),
  pitch(Colors.deepPurpleAccent);

  final Color color;
  const SoundOptions(this.color);
}

extension ESoundOptions on SoundOptions {
  String get label {
    switch (this) {
      case SoundOptions.speedRate:
        return AppString.speedRate.tr;
      case SoundOptions.volumn:
        return AppString.volumn.tr;
      case SoundOptions.pitch:
        return AppString.pitch.tr;
    }
  }
}

enum QuizDuration { incorrect, correct }

extension EQuizDuration on QuizDuration {
  String get label {
    switch (this) {
      case QuizDuration.incorrect:
        return AppString.whenIncorrect.tr;
      case QuizDuration.correct:
        return AppString.whenCorrect.tr;
    }
  }
}
