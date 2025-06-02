import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:jonggack_topik/core/models/category.dart';
import 'package:jonggack_topik/core/models/chapter.dart';
import 'package:jonggack_topik/core/models/subject.dart';
import 'package:jonggack_topik/features/chapter/controller/chapter_controller.dart';
import 'package:jonggack_topik/features/chapter/screen/chapter_screen.dart';

class SubjectController extends GetxController {
  final Category _category;
  SubjectController(this._category);

  String get categoryTitle => _category.title;
  List<Subject> get subjects => _category.subjects;
  final _selectedSubjectIndex = 0.obs;
  int get selectedSubjectIndex => _selectedSubjectIndex.value;

  Subject get selectedSubject => subjects[_selectedSubjectIndex.value];

  final carouselController = CarouselSliderController();

  int _selectedChapter = 0;
  Chapter get chapter => selectedSubject.chapters[_selectedChapter];

  onTapChapter(int index) {
    _selectedChapter = index;
    Get.to(
      () => ChapterScreen(),
      binding: BindingsBuilder.put(() => ChapterController(chapter)),
    );
  }

  changeSubject(int index) {
    carouselController.jumpToPage(0);
    // setState(() {
    _selectedSubjectIndex.value = index;
    // });
  }
}
