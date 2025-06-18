import 'dart:math';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/core/models/category_hive.dart';
import 'package:jonggack_topik/core/models/chapter_hive.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
import 'package:jonggack_topik/features/auth/controllers/user_controller.dart';

class RandomWordService {
  static const _prefKey = 'lastShownDate'; // 마지막으로 단어를 보여준 날짜 (YYYY-MM-DD 형식)
  static const _prefWord = 'lastShownWord'; // 마지막으로 보여준 단어 (선택 사항)
  static int _getSubjectIndexFromLastSelected() {
    String lastSelected =
        SettingRepository.getString(AppConstant.lastSelected) ??
        "1・2級-${AppConstant.defaultCategory}";

    String level = lastSelected.split('-${AppConstant.defaultCategory}')[0];

    int subjectIndex = 0;
    switch (level) {
      case "1・2級":
        subjectIndex = 0;
        break;
      case "3・4級":
        subjectIndex = 1;
        break;
      case "5・6級":
        subjectIndex = 2;
        break;
    }
    return subjectIndex;
  }

  static List<Word> createRandomWordBySubject({
    String categoryName = '韓国語能力試験',
    int? subjectIndex,
    int quizNumber = 15,
  }) {
    final stepRepo = Get.find<HiveRepository<StepModel>>(tag: StepModel.boxKey);
    final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);

    Random random = Random();

    final categoryRepo = Get.find<HiveRepository<CategoryHive>>(
      tag: CategoryHive.boxKey,
    );

    final category = categoryRepo.get(categoryName);
    subjectIndex = subjectIndex ?? _getSubjectIndexFromLastSelected();
    final subject = category!.subjects[subjectIndex];

    List<Word> randomWord = [];
    for (int i = 0; randomWord.length != quizNumber; i++) {
      int randomChapterIdx = 0;
      // 무료 버전 제한
      if (subjectIndex >= 2 && !UserController.to.user.isPremieum) {
        randomChapterIdx = random.nextInt(
          subject.chapters.length > AppConstant.defaultAccessableIndex
              ? AppConstant.defaultAccessableIndex
              : subject.chapters.length,
        );
      } else {
        randomChapterIdx = random.nextInt(subject.chapters.length);
      }

      ChapterHive chapterHive = subject.chapters[randomChapterIdx];

      int randomInt = random.nextInt(chapterHive.stepKeys.length);
      String stepKey = chapterHive.stepKeys[randomInt];
      StepModel stepModel = stepRepo.get(stepKey)!;

      String wordId = stepModel.words[random.nextInt(stepModel.words.length)];
      Word? word = wordRepo.get(wordId);
      if (word == null) continue;
      randomWord.add(wordRepo.get(wordId)!);
    }

    return randomWord;
  }

  static int aa(int chpatersI) {
    return 0;
  }

  static List<Word> createDefaultRandomWords() {
    final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);
    Random random = Random();
    List<Word> allWords = wordRepo.getAll();
    List<Word> recommendWords = [];

    for (int i = 0; i < 15; i++) {
      int randomeIndex = random.nextInt(allWords.length);
      recommendWords.add(allWords[randomeIndex]);
    }
    return recommendWords;
  }

  static Future<List<Word>> createRandomWords() async {
    final wordListRepo = await Hive.openBox<List<dynamic>>("wordList");

    final savedDate = SettingRepository.getString(_prefKey);
    final savedWord = wordListRepo.get(_prefWord);

    final now = DateTime.now();
    final todayString = now.toIso8601String().split('T').first;

    if (savedDate == todayString && savedWord != null) {
      return (savedWord).cast<Word>();
    }
    Random random = Random();

    List<Word> recommendWords = createDefaultRandomWords();
    final wordRepo = Get.find<HiveRepository<Word>>(tag: Word.boxKey);
    String? lastSelected = SettingRepository.getString(
      AppConstant.lastSelected,
    );

    if (lastSelected == null) return recommendWords;

    LogManager.info('랜덤 Quiz 생성중 ... 마지막 선택된 카테고리 : $lastSelected');
    List<String> parts = lastSelected.split(
      '-${AppConstant.selectedCategoryIdx}',
    );
    if (parts.length < 2) return recommendWords;

    List<String> prefixSegments = parts.first.split('-');
    final stepRepo = Get.find<HiveRepository<StepModel>>(tag: StepModel.boxKey);

    switch (prefixSegments.length) {
      case 3: // 暮らし-洗濯・掃除-Chapter 1
        final categoryRepo = Get.find<HiveRepository<ChapterHive>>(
          tag: ChapterHive.boxKey,
        );
        final chapterHive = categoryRepo.get(parts[0]);

        if (chapterHive == null) return recommendWords;

        int randomInt = random.nextInt(chapterHive.stepKeys.length);
        String stepKey = chapterHive.stepKeys[randomInt];
        StepModel? stepModel = stepRepo.get(stepKey);
        if (stepModel == null) return recommendWords;

        recommendWords.assignAll(
          stepModel.words.map((id) => wordRepo.get(id)!).toList(),
        );

        break;
      case 2: // 暮らし-洗濯・掃除
        final subjectRepo = HiveRepository<SubjectHive>(SubjectHive.boxKey);
        await subjectRepo.initBox();
        final subject = subjectRepo.get(parts[0]);

        if (subject == null) return recommendWords;

        int randomInt = random.nextInt(subject.chapters.length);
        ChapterHive chapterHive = subject.chapters[randomInt];

        randomInt = random.nextInt(chapterHive.stepKeys.length);
        String stepKey = chapterHive.stepKeys[randomInt];
        StepModel? stepModel = stepRepo.get(stepKey);
        if (stepModel == null) return recommendWords;

        recommendWords.assignAll(
          stepModel.words.map((id) => wordRepo.get(id)!).toList(),
        );
        break;
      case 1: // 暮らし
        final categoryRepo = HiveRepository<CategoryHive>(CategoryHive.boxKey);
        await categoryRepo.initBox();
        final category = categoryRepo.get(parts[0]);

        if (category == null) return recommendWords;
        int randomInt = random.nextInt(category.subjects.length);

        SubjectHive subjectHive = category.subjects[randomInt];
        randomInt = random.nextInt(subjectHive.chapters.length);
        ChapterHive chapterHive = subjectHive.chapters[randomInt];

        randomInt = random.nextInt(chapterHive.stepKeys.length);
        String stepKey = chapterHive.stepKeys[randomInt];
        StepModel? stepModel = stepRepo.get(stepKey);
        if (stepModel == null) return recommendWords;

        recommendWords.assignAll(
          stepModel.words.map((id) => wordRepo.get(id)!).toList(),
        );
        break;
      default:
        break;
    }

    SettingRepository.setString(_prefKey, todayString);
    await wordListRepo.put(_prefWord, recommendWords);
    return recommendWords;
  }
}
