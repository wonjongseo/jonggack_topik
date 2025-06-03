import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/category_hive.dart';
import 'package:jonggack_topik/core/models/chapter_hive.dart';
import 'package:jonggack_topik/core/models/subject_hive.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/chapter/screen/chapter_screen.dart';

class SubjectController extends GetxController {
  static SubjectController get to => Get.find<SubjectController>();

  final CategoryHive _category;
  SubjectController(this._category);

  String get categoryTitle => _category.title;
  List<SubjectHive> get subjects => _category.subjects;
  final _selectedSubjectIndex = 0.obs;
  int get selectedSubjectIndex => _selectedSubjectIndex.value;

  SubjectHive get selectedSubject => subjects[_selectedSubjectIndex.value];

  final carouselController = CarouselSliderController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _selectedSubjectIndex.value =
        SettingRepository.getInt(
          '${_category.title}-${AppConstant.selectedCategoryIdx}',
        ) ??
        0;

    String key =
        '${selectedSubject.title}-${_category.title}-${AppConstant.selectedCategoryIdx}';

    _selectedChapter = SettingRepository.getInt(key) ?? 0;

    carouselController.animateToPage(_selectedChapter);
    super.onReady();
  }

  //5・6級-韓国語能力試験-selectedCategoryIdx
  int _selectedChapter = 0;
  ChapterHive get chapter => selectedSubject.chapters[_selectedChapter];

  void onTapChapter(int index) {
    _selectedChapter = index;

    String key =
        '${selectedSubject.title}-${_category.title}-${AppConstant.selectedCategoryIdx}';

    SettingRepository.setInt(key, _selectedChapter);

    Get.to(
      () => ChapterScreen(),
      binding: BindingsBuilder.put(() => ChapterController(chapter)),
    );
  }

  void changeSubject(int index) {
    _selectedSubjectIndex.value = index;
    String key =
        '${selectedSubject.title}-${_category.title}-${AppConstant.selectedCategoryIdx}';

    int tempIndex = SettingRepository.getInt(key) ?? 0;

    carouselController.animateToPage(tempIndex);

    SettingRepository.setInt(
      '${_category.title}-${AppConstant.selectedCategoryIdx}',
      _selectedSubjectIndex.value,
    );
  }
}
