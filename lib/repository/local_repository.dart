import 'dart:developer';

import 'package:get/get_utils/src/platform/platform.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jonggack_topik/features/home/widgets/home_screen_body.dart';
import 'package:jonggack_topik/model/Question.dart';
import 'package:jonggack_topik/model/example.dart';
import 'package:jonggack_topik/model/hive_type.dart';
import 'package:jonggack_topik/model/my_word.dart';
import 'package:jonggack_topik/model/jlpt_step.dart';
import 'package:jonggack_topik/model/synonym.dart';
import 'package:jonggack_topik/model/word.dart';

import '../model/user.dart';

class LocalReposotiry {
  static Future<void> init() async {
    if (GetPlatform.isMobile) {
      await Hive.initFlutter();
    } else if (GetPlatform.isWindows) {
      Hive.init("C:/jlpt_app/assets/hive");
    }

    if (!Hive.isAdapterRegistered(UserTypeId)) {
      Hive.registerAdapter(UserAdapter());
    }

    if (!Hive.isAdapterRegistered(WordTypeId)) {
      Hive.registerAdapter(WordAdapter());
    }

    if (!Hive.isAdapterRegistered(MyWordTypeId)) {
      Hive.registerAdapter(MyWordAdapter());
    }

    if (!Hive.isAdapterRegistered(JlptStepTypeId)) {
      Hive.registerAdapter(JlptStepAdapter());
    }

    if (!Hive.isAdapterRegistered(ExampleTypeId)) {
      Hive.registerAdapter(ExampleAdapter());
    }
    if (!Hive.isAdapterRegistered(SynonymsTypeId)) {
      Hive.registerAdapter(SynonymAdapter());
    }

    if (!Hive.isAdapterRegistered(QuestionTypeId)) {
      Hive.registerAdapter(QuestionAdapter());
    }

    if (!Hive.isBoxOpen('homeTutorialKey')) {
      await Hive.openBox('homeTutorialKey');
    }

    if (!Hive.isBoxOpen('grammarTutorialKey')) {
      await Hive.openBox('grammarTutorialKey');
    }

    if (!Hive.isBoxOpen('wordStudyTutorialKey')) {
      await Hive.openBox('wordStudyTutorialKey');
    }

    if (!Hive.isBoxOpen('myWordTutorialKey')) {
      await Hive.openBox('myWordTutorialKey');
    }

    if (!Hive.isBoxOpen('currentProgressingKey')) {
      await Hive.openBox('currentProgressingKey');
    }

    if (!Hive.isBoxOpen('textKeyBoardKey')) {
      await Hive.openBox('textKeyBoardKey');
    }

    if (!Hive.isBoxOpen('userJlptLevelKey')) {
      await Hive.openBox('userJlptLevelKey');
    }

    // SOUND
    if (!Hive.isBoxOpen('volumnKey')) {
      await Hive.openBox('volumnKey');
    }

    if (!Hive.isBoxOpen('pitchKey')) {
      await Hive.openBox('pitchKey');
    }

    if (!Hive.isBoxOpen('rateKey')) {
      await Hive.openBox('rateKey');
    }

    // TODO DELETE
    if (!Hive.isBoxOpen('enableJapaneseSoundKey')) {
      await Hive.openBox('enableJapaneseSoundKey');
    }

    if (!Hive.isBoxOpen('enableKoreanSoundKey')) {
      await Hive.openBox('enableKoreanSoundKey');
    }
    if (!Hive.isBoxOpen('basicOrJlptOrMy')) {
      await Hive.openBox('basicOrJlptOrMy');
    }

    if (!Hive.isBoxOpen('jlptOrKangiOrGrarmmar')) {
      await Hive.openBox('jlptOrKangiOrGrarmmar');
    }

    if (!Hive.isBoxOpen(User.boxKey)) {
      await Hive.openBox(User.boxKey);
    }

    if (!Hive.isBoxOpen(JlptStep.boxKey)) {
      await Hive.openBox(JlptStep.boxKey);
    }

    if (!Hive.isBoxOpen(Example.boxKey)) {
      await Hive.openBox(Example.boxKey);
    }

    if (!Hive.isBoxOpen(Word.boxKey)) {
      await Hive.openBox<Word>(Word.boxKey);
    }

    if (!Hive.isBoxOpen(MyWord.boxKey)) {
      await Hive.openBox<MyWord>(MyWord.boxKey);
    }

    if (!Hive.isBoxOpen('usageCount')) {
      await Hive.openBox('usageCount');
    }

    if (!Hive.isBoxOpen('hasReviewed')) {
      await Hive.openBox('hasReviewed');
    }
    if (!Hive.isBoxOpen('lastRunDate')) {
      await Hive.openBox('lastRunDate');
    }
  }

  static bool isSeenHomeTutorial() {
    final homeTutorialBox = Hive.box('homeTutorialKey');
    String key = 'homeTutorial';

    if (!homeTutorialBox.containsKey(key)) {
      homeTutorialBox.put(key, true);
      return false;
    }

    if (homeTutorialBox.get(key) == false) {
      homeTutorialBox.put(key, true);
      return false;
    }

    return true;
  }

  static bool testKeyBoardOnfOFF() {
    final list = Hive.box('textKeyBoardKey');
    String key = 'textKeyBoard';

    if (!list.containsKey(key)) {
      list.put(key, false);
      return false;
    }
    bool isTextKeyBoard = list.get(key);

    list.put(key, !isTextKeyBoard);
    return !isTextKeyBoard;
  }

  static int getJlptOrKangiOrGrammar(String level) {
    final list = Hive.box('jlptOrKangiOrGrarmmar');

    int result = list.get(level, defaultValue: 0);

    return result;
  }

  static int putJlptOrKangiOrGrammar(String level, int index) {
    final list = Hive.box('jlptOrKangiOrGrarmmar');

    list.put(level, index);

    return index;
  }

  static int getCurrentProgressing(String key) {
    final list = Hive.box('currentProgressingKey');

    int result = list.get(key, defaultValue: 0);

    return result;
  }

  static int putCurrentProgressing(String key, int index) {
    // JLPT급 수 당 현재 챕터 정보 ex) N2급의 Chapter 3
    final list = Hive.box('currentProgressingKey');
    list.put(key, index);

    return index;
  }

  static bool getTestKeyBoard() {
    final list = Hive.box('textKeyBoardKey');
    String key = 'textKeyBoard';
    return list.get(key, defaultValue: true);
  }

  static int getBasicOrJlptOrMy() {
    final list = Hive.box('basicOrJlptOrMy');
    String key = 'basicOrJlptOrMyKey';
    int level = list.get(key, defaultValue: 0);

    return level;
  }

  static int getBasicOrJlptOrMyDetail(KindOfStudy kindOfStudy) {
    final list = Hive.box('basicOrJlptOrMy');
    int level = list.get(kindOfStudy.name, defaultValue: 0);
    return level;
  }

  static int putBasicOrJlptOrMyDetail(KindOfStudy kindOfStudy, int index) {
    switch (kindOfStudy) {
      case KindOfStudy.BASIC:
        if (index > 1) return 0;
        break;
      case KindOfStudy.JLPT:
        if (index > 4) return 0;
        break;
      case KindOfStudy.MY:
        if (index > 1) return 0;
        break;
    }
    final list = Hive.box('basicOrJlptOrMy');
    list.put(kindOfStudy.name, index);

    return index;
  }

  // 왕초보 단어장 ? JLPT단어장 ? 나만의 단어장 ?
  static int putBasicOrJlptOrMy(int index) {
    final list = Hive.box('basicOrJlptOrMy');
    String key = 'basicOrJlptOrMyKey';
    list.put(key, index);

    return index;
  }

  static int getUserJlptLevel(String key) {
    final list = Hive.box('userJlptLevelKey');
    int level = list.get(key, defaultValue: 0);

    return level;
  }

  static Future<void> updateUserJlptLevel(int level) async {
    final list = Hive.box('userJlptLevelKey');
    String key = 'userJlptLevel';

    await list.put(key, level);
  }

  static double getVolumn() {
    final list = Hive.box('volumnKey');
    String key = 'volumn';
    double volumn = list.get(key, defaultValue: 1.0);

    return volumn;
  }

  static bool updateVolumn(double newValue) {
    final list = Hive.box('volumnKey');
    String key = 'volumn';
    try {
      list.put(key, newValue);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static double getPitch() {
    final list = Hive.box('pitchKey');
    String key = 'pitch';
    double pitch = list.get(key, defaultValue: 1.0);

    return pitch;
  }

  static bool updatePitch(double newValue) {
    final list = Hive.box('pitchKey');
    String key = 'pitch';
    try {
      list.put(key, newValue);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static double getRate() {
    final list = Hive.box('rateKey');
    String key = 'rate';
    double rate = list.get(key, defaultValue: 0.4);

    return rate;
  }

  static bool updateRate(double newValue) {
    final list = Hive.box('rateKey');
    String key = 'rate';
    try {
      list.put(key, newValue);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static int aaa() {
    final list = Hive.box('usageCount');
    int usageCount = list.get('usageCount', defaultValue: 0) + 1;

    list.put('usageCount', usageCount);

    return usageCount;
  }

  static bool bbb() {
    final list = Hive.box('hasReviewed');

    return list.get('hasReviewed', defaultValue: false);
  }

  static void ccc() {
    final list = Hive.box('hasReviewed');

    list.put('hasReviewed', true);
  }

  static Future<void> saveLastRunDate() async {
    print('saveLastRunDate');
    final list = Hive.box('lastRunDate');
    list.put('lastRunDate', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<bool> is30DaysPassed() async {
    final list = Hive.box('lastRunDate');

    int? lastRunDate = list.get('lastRunDate');

    if (lastRunDate == null) {
      return true;
    }

    DateTime lastRun = DateTime.fromMillisecondsSinceEpoch(lastRunDate);

    DateTime currentDate = DateTime.now();

    Duration difference = currentDate.difference(lastRun);

    return difference.inDays >= 30;
  }

  static Future<bool> checkAndExecuteFunction() async {
    if (await is30DaysPassed()) {
      await saveLastRunDate();
      return true;
    }
    return false;
  }
}
