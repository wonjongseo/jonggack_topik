import 'package:hive_flutter/adapters.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/Question.dart';
import 'package:jonggack_topik/core/models/category.dart';
import 'package:jonggack_topik/core/models/category_hive.dart';
import 'package:jonggack_topik/core/models/chapter.dart';
import 'package:jonggack_topik/core/models/chapter_hive.dart';
import 'package:jonggack_topik/core/models/example.dart';
import 'package:jonggack_topik/core/models/step_model.dart';
import 'package:jonggack_topik/core/models/subject.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
import 'package:jonggack_topik/core/models/synonym.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/features/auth/models/user.dart';

class HiveRepository<T extends HiveObject> {
  static HiveRepository get to => Get.find<HiveRepository>();

  final String boxKey;
  late Box<T> _box;

  HiveRepository(this.boxKey);

  /// 1) 박스 초기화: openBox 또는 이미 열려 있으면 box() 호출
  Future<void> initBox() async {
    if (!Hive.isBoxOpen(boxKey)) {
      _box = await Hive.openBox<T>(boxKey);
    } else {
      _box = Hive.box<T>(boxKey);
    }
  }

  /// 2) 단일 엔티티 저장/업데이트 (key: String)
  Future<void> put(String key, T value) async {
    try {
      await _box.put(key, value);
    } catch (e) {
      print('e.toString() : ${e.toString()}');
    }
  }

  /// 3) key로 조회
  T? get(String key) {
    return _box.get(key);
  }

  /// 4) key로 삭제
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  /// 5) 모든 값 가져오기
  List<T> getAll() {
    return _box.values.toList();
  }

  /// 6) 존재 여부 체크
  bool containsKey(String key) {
    return _box.containsKey(key);
  }

  /// 7) 한 번에 여러 개(batch) 저장하기 (Map<key, T> 형태)
  Future<void> putAll(Map<String, T> items) async {
    await _box.putAll(items);
  }

  /// 8) 박스 닫기
  Future<void> closeBox() async {
    await _box.close();
  }

  Future<void> deleteFromDisk() async {
    print('${_box.runtimeType} is deleteFromDisk');
    await _box.deleteFromDisk();
  }

  static Future<void> init() async {
    if (GetPlatform.isMobile) {
      await Hive.initFlutter();
    }

    if (!Hive.isAdapterRegistered(HK.categoryHiveTypeID)) {
      Hive.registerAdapter(CategoryHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(HK.chapterHiveTypeID)) {
      Hive.registerAdapter(ChapterHiveAdapter());
    }
    if (!Hive.isAdapterRegistered(HK.subjectHiveTypeID)) {
      Hive.registerAdapter(SubjectHiveAdapter());
    }

    if (!Hive.isAdapterRegistered(HK.categoryTypeID)) {
      Hive.registerAdapter(CategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(HK.subjectTypeID)) {
      Hive.registerAdapter(SubjectAdapter());
    }
    if (!Hive.isAdapterRegistered(HK.chapterTypeID)) {
      Hive.registerAdapter(ChapterAdapter());
    }
    if (!Hive.isAdapterRegistered(HK.stepTypeID)) {
      Hive.registerAdapter(StepModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HK.wordTypeID)) {
      Hive.registerAdapter(WordAdapter());
    }
    if (!Hive.isAdapterRegistered(ExampleAdapter().typeId)) {
      Hive.registerAdapter(ExampleAdapter());
    }
    if (!Hive.isAdapterRegistered(SynonymAdapter().typeId)) {
      Hive.registerAdapter(SynonymAdapter());
    }
    if (!Hive.isAdapterRegistered(QuestionAdapter().typeId)) {
      Hive.registerAdapter(QuestionAdapter());
    }

    if (!Hive.isBoxOpen(AppConstant.settingModelBox)) {
      await Hive.openBox(AppConstant.settingModelBox);
    }

    if (!Hive.isBoxOpen(User.boxKey)) {
      await Hive.openBox<User>(User.boxKey);
    }
    if (!Hive.isBoxOpen(CategoryHive.boxKey)) {
      await Hive.openBox<CategoryHive>(CategoryHive.boxKey);
    }
    if (!Hive.isBoxOpen(SubjectHive.boxKey)) {
      await Hive.openBox<SubjectHive>(SubjectHive.boxKey);
    }

    if (!Hive.isBoxOpen(ChapterHive.boxKey)) {
      await Hive.openBox<ChapterHive>(ChapterHive.boxKey);
    }
    if (!Hive.isBoxOpen(Category.boxKey)) {
      await Hive.openBox<Category>(Category.boxKey);
    }
    if (!Hive.isBoxOpen(Subject.boxKey)) {
      await Hive.openBox<Subject>(Subject.boxKey);
    }
    if (!Hive.isBoxOpen(Chapter.boxKey)) {
      await Hive.openBox<Chapter>(Chapter.boxKey);
    }
    if (!Hive.isBoxOpen(StepModel.boxKey)) {
      await Hive.openBox<StepModel>(StepModel.boxKey);
    }
    if (!Hive.isBoxOpen(Word.boxKey)) {
      await Hive.openBox<Word>(Word.boxKey);
    }
    if (!Hive.isBoxOpen(Example.boxKey)) {
      await Hive.openBox<Example>(Example.boxKey);
    }
    if (!Hive.isBoxOpen(Synonym.boxKey)) {
      await Hive.openBox<Synonym>(Synonym.boxKey);
    }
    if (!Hive.isBoxOpen(Question.boxKey)) {
      await Hive.openBox<Question>(Question.boxKey);
    }

    SettingRepository.init();

    final wordRepo = HiveRepository<Word>(Word.boxKey);
    await wordRepo.initBox();

    final myWordRepo = HiveRepository<Word>(HK.myWordBoxKey);
    await myWordRepo.initBox();

    Get.put<HiveRepository<Word>>(wordRepo, tag: Word.boxKey);
    Get.put<HiveRepository<Word>>(myWordRepo, tag: HK.myWordBoxKey);

    // 만약 StepModel 박스도 DI에 등록하려면
    final stepRepo = HiveRepository<StepModel>(StepModel.boxKey);
    await stepRepo.initBox();
    Get.put<HiveRepository<StepModel>>(stepRepo, tag: StepModel.boxKey);

    final categoryRepo = HiveRepository<Category>(Category.boxKey);
    await categoryRepo.initBox();
    Get.put<HiveRepository<Category>>(categoryRepo, tag: Category.boxKey);
  }

  // static void getWord(String wordId) {
  //   final wordBox = Hive.box<Word>(Word.boxKey);
  //   Word? word = wordBox.get(wordId);
  //   print('word : ${word}');
  // }

  static Future<void> saveCategory(Category category) async {
    final categoryBox = Hive.box<Category>(Category.boxKey);

    if (categoryBox.containsKey(category.title)) {
      return;
    }
    await categoryBox.put(category.title, category);

    final stepBox = Hive.box<StepModel>(StepModel.boxKey);
    final wordBox = Hive.box<Word>(Word.boxKey);

    for (final subject in category.subjects) {
      for (final chapter in subject.chapters) {
        for (final step in chapter.steps) {
          final stepKey =
              '${category.title}-${subject.title}-${chapter.title}-${step.title}';

          if (!stepBox.containsKey(stepKey)) {
            await stepBox.put(stepKey, step);
          }

          for (final word in step.words) {
            if (!wordBox.containsKey(word.id)) {
              await wordBox.put(word.id, word);
            }
          }
        }
      }
    }
  }
}
