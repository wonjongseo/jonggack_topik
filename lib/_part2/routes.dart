import 'package:get/get.dart';
import 'package:jonggack_topik/_part2/features/chapter/screen/chapter_screen.dart';
import 'package:jonggack_topik/_part2/features/main/screens/main_screen.dart';
import 'package:jonggack_topik/_part2/features/subject/screen/subject_screen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> getPages = [
    GetPage(name: MainScreen.name, page: () => const MainScreen()),
    GetPage(name: SubjectScreen.name, page: () => const SubjectScreen()),
    GetPage(name: ChapterScreen.name, page: () => const ChapterScreen()),
  ];
}
