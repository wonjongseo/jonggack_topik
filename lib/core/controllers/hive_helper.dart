// import 부분
import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/models/category.dart';
import 'package:jonggack_topik/core/models/category_hive.dart';
import 'package:jonggack_topik/core/models/chapter_hive.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
import 'package:jonggack_topik/core/models/word.dart';

class HiveHelper {
  /// 원본 Category (Category → Subject → Chapter → List<StepModel>)를 받아 Hive에 저장
  static Future<void> saveCategory(List<Category> categorys) async {
    // 1) Hive 박스들 열기
    final categoryBox = Hive.box<CategoryHive>(CategoryHive.boxKey);
    final subjectBox = Hive.box<SubjectHive>(SubjectHive.boxKey);
    final chapterBox = Hive.box<ChapterHive>(ChapterHive.boxKey);
    final stepBox = Hive.box<StepModel>(StepModel.boxKey);
    final wordBox = Hive.box<Word>(Word.boxKey);

    // 2) Subject 순회
    for (var category in categorys) {
      final List<SubjectHive> subjectHiveList = [];
      for (final subj in category.subjects) {
        final List<ChapterHive> chapterHiveList = [];

        // 3) Chapter 순회
        for (final chap in subj.chapters) {
          final List<String> stepKeys = [];

          // 4) StepModel 순회 → stepBox에 저장하고, 키 목록에 추가
          for (final step in chap.steps) {
            final stepKey =
                '${category.title}-${subj.title}-${chap.title}-${step.title}';

            // 4-1) stepBox: StepModel 저장
            if (!stepBox.containsKey(stepKey)) {
              await stepBox.put(stepKey, step);
            }
            stepKeys.add(stepKey);

            // 4-2) Word도 함께 저장
            for (final word in step.words) {
              if (!wordBox.containsKey(word.id)) {
                await wordBox.put(word.id, word);
              }
            }
          }

          // 5) ChapterHive 생성 → chapterBox에 저장
          final chapKey = '${category.title}-${subj.title}-${chap.title}';
          final hiveChapter = ChapterHive(
            title: chap.title,
            stepKeys: stepKeys,
          );
          if (!chapterBox.containsKey(chapKey)) {
            await chapterBox.put(chapKey, hiveChapter);
          }
          chapterHiveList.add(hiveChapter);
        }

        // 6) SubjectHive 생성 → subjectBox에 저장
        final subjKey = '${category.title}-${subj.title}';
        final hiveSubject = SubjectHive(
          title: subj.title,
          chapters: chapterHiveList,
        );
        if (!subjectBox.containsKey(subjKey)) {
          await subjectBox.put(subjKey, hiveSubject);
        }
        subjectHiveList.add(hiveSubject);
      }

      // 7) CategoryHive 생성 → categoryBox에 저장
      final hiveCategory = CategoryHive(
        title: category.title,
        subjects: subjectHiveList,
      );
      if (!categoryBox.containsKey(category.title)) {
        await categoryBox.put(category.title, hiveCategory);
      }
    }
  }
}
