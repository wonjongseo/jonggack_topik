import 'package:get/get.dart';

const double appBarHeight = 35;
const double appBarTextSize = 18;

class AppConstant {
  static const String firstDay = "firstDay";
  static const String lastDay = "lastDay";

  static const String selectedCategoryIdx = 'selectedCategoryIdx';
  static const String lastSelected = 'lastSelected';

  static const int diaryModelHiveId = 0;
  static const int healthModelHiveId = 1;
  static const int hospitalLogModelHiveId = 2;
  static const int stampModelHiveId = 3;
  static const int todoModelHiveId = 4;
  static const int userModelHiveId = 5;
  static const int regularTaskModelHiveId = 6;
  static const int notificationModelHiveId = 7;
  static const int taskModelHiveId = 8;
  static const int userUtilModelHiveId = 9;
  static const int bloodPressureModelHiveId = 10;
  static const int dayPeriodTypeHiveId = 11;
  static const int weekDayTypeHiveId = 12;
  static const int donePillDayModelHiveId = 13;
  static const int isExpandtionTypeHiveId = 14;
  static const int poopConditionTypeHiveId = 15;
  static const int poopConditionModelHiveId = 16;

  static const String settingModelBox = 'settings';
  static const String diaryModelBox = 'diarys';
  static const String hospitalLogModelBox = 'hospitalLogs';
  static const String userModelBox = 'users';
  static const String todoModelBox = 'todos';

  static const String expensiveModelModelBox = 'expensives';
  static const String categoryModelModelBox = 'categories';
  static const String groceriesModelModelBox = 'groceries';
  static const String settingLanguageKey = 'settingLanguage';
  static const String lastPetIndexKey = 'lastPetIndex';
  static const String lastBottomTapIndexKey = 'lastBottomTapIndex';
  static const String hospitalNamesBox = 'hospitalNames';
  static const String officeNamesBox = 'officeNames';
  static const String diseaseNamesBox = 'diseaseNames';
  static const String pillNamesBox = 'pillNames';

  static const String countOfReiveRequestionKey = 'countOfReiveRequestion';
  static const String hasReviewedKey = 'hasReviewed';
  static const String isDarkModeKey = 'isDarkMode';

  static const int countOfStampIcon = 18;

  static const String editCategorySign = "-@+편집+@-";

  static const int invalidNumber = -9192939;

  // static List<String> fillingIcons1 = [
  //   AppImagePath.very_good1,
  //   AppImagePath.good1,
  //   AppImagePath.soso1,
  //   AppImagePath.bad1,
  //   AppImagePath.very_bad1,
  // ];

  // static List<String> fillingIcons2 = [
  //   AppImagePath.very_good2,
  //   AppImagePath.good2,
  //   AppImagePath.soso2,
  //   AppImagePath.bad2,
  //   AppImagePath.very_bad2,
  // ];

  // static List<String> fillingIcons3 = [
  //   AppImagePath.very_good3,
  //   AppImagePath.good3,
  //   AppImagePath.soso3,
  //   AppImagePath.bad3,
  //   AppImagePath.very_bad3,
  // ];

  // static List<String> fillingIcons4 = [
  //   AppImagePath.very_good4,
  //   AppImagePath.good4,
  //   AppImagePath.soso4,
  //   AppImagePath.bad4,
  //   AppImagePath.very_bad4,
  // ];
  // static List<String> fillingIcons5 = [
  //   AppImagePath.very_good5,
  //   AppImagePath.good5,
  //   AppImagePath.soso5,
  //   AppImagePath.bad5,
  //   AppImagePath.very_bad5,
  // ];

  // static List<IconAndIndex> weatherIcons = [
  //   IconAndIndex.sun,
  //   IconAndIndex.cloud,
  //   IconAndIndex.wind,
  //   IconAndIndex.umbrella,
  //   IconAndIndex.snowflake,
  // ];

  // static List<IconAndIndex> zeroToNineIcons = [
  //   IconAndIndex.zero,
  //   IconAndIndex.one,
  //   IconAndIndex.two,
  //   IconAndIndex.three,
  //   IconAndIndex.four,
  //   IconAndIndex.five,
  //   IconAndIndex.six,
  //   IconAndIndex.seven,
  //   IconAndIndex.eight,
  //   IconAndIndex.nine,
  // ];

  // static List<BackgroundData> backgroundLists = [
  //   BackgroundData(
  //     images: [
  //       AppImagePath.background11,
  //       AppImagePath.background12,
  //       AppImagePath.background13,
  //     ],
  //     description: AppString.background1Desc.tr,
  //     lefts: [80, -120, 120],
  //     rights: [-80, 120, -120],
  //     tops: [-100, 160, 400],
  //     scales: [.6, .8, 1],
  //     opacity: [.2, .5],
  //   ),
  //   BackgroundData(
  //     // 다람쥐
  //     images: [
  //       AppImagePath.background22,
  //       // AppImagePath.background23,
  //       AppImagePath.background22,
  //       AppImagePath.background21,
  //     ],
  //     description: AppString.background2Desc.tr,
  //     lefts: [85, -120, 120],
  //     rights: [-85, 120, -120],
  //     tops: [-100, 140, 350],
  //     scales: [.5, .5, 1],
  //     opacity: [.2, .3],
  //   ),
  //   BackgroundData(
  //     images: [
  //       AppImagePath.background33,
  //       AppImagePath.background32,
  //       AppImagePath.background31,
  //     ],
  //     description: AppString.background3Desc.tr,
  //     lefts: [85, -120, 120],
  //     rights: [-85, 120, -120],
  //     tops: [-100, 160, 350],
  //     scales: [1, .6, .8],
  //     opacity: [.5, .3],
  //   ),
  //   BackgroundData(
  //     images: [
  //       AppImagePath.background41,
  //       AppImagePath.background43,
  //       AppImagePath.background42,
  //     ],
  //     description: AppString.background4Desc.tr,
  //     lefts: [80, -120, 120],
  //     rights: [-80, 120, -120],
  //     tops: [-100, 160, 400],
  //     scales: [.6, .8, 1],
  //     opacity: [.2, .5],
  //   ),
  //   BackgroundData(
  //     images: [
  //       AppImagePath.background51,
  //       AppImagePath.background52,
  //       AppImagePath.background53,
  //     ],
  //     description: AppString.background5Desc.tr,
  //     lefts: [80, -120, 120],
  //     rights: [-80, 120, -120],
  //     tops: [-100, 160, 400],
  //     scales: [.6, .8, 1],
  //     opacity: [.2, .5],
  //   ),
  //   BackgroundData(
  //     images: [],
  //     description: AppString.noBackground.tr,
  //     lefts: [],
  //     rights: [],
  //     tops: [],
  //     scales: [],
  //     opacity: [1, 1], // dont' remove this
  //   ),
  // ];

  // static List<FealIconData> fealIconLists = [
  //   FealIconData(
  //       iconPath: AppConstant.fillingIcons1,
  //       title: AppString.fealIcon1Name.tr,
  //       description: AppString.fealIcon1Des.tr),
  //   FealIconData(
  //       iconPath: AppConstant.fillingIcons2,
  //       title: AppString.fealIcon2Name.tr,
  //       description: AppString.fealIcon2Des.tr),
  //   FealIconData(
  //       iconPath: AppConstant.fillingIcons3,
  //       title: AppString.fealIcon3Name.tr,
  //       description: AppString.fealIcon3Des.tr),
  //   FealIconData(
  //       iconPath: AppConstant.fillingIcons4,
  //       title: AppString.fealIcon4Name.tr,
  //       description: AppString.fealIcon4Des.tr),
  //   FealIconData(
  //       iconPath: AppConstant.fillingIcons5,
  //       title: AppString.fealIcon5Name.tr,
  //       description: AppString.fealIcon5Des.tr),
  // ];
}

class IconAndText {
  final String text;
  final int iconIndex;

  IconAndText({required this.text, required this.iconIndex});
}
