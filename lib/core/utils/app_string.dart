import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'ja_JP': {
      AppString.beforeStart: AppString.beforeStartJp,
      AppString.plzSetting: AppString.plzSettingJp,
      AppString.back: AppString.backJp,
      AppString.selectGoalLevel: AppString.selectGoalLevelJp,
      AppString.doYouWantToAlert: AppString.doYouWantToAlertJp,

      AppString.cancelBtnTextTr: AppString.cancelBtnTextJp,
      AppString.plzAlarmTime: AppString.plzAlarmTimeJp,
      AppString.plzInputCollectTime: AppString.plzInputCollectTimeJp,

      AppString.hour: AppString.hourJp,
      AppString.minute: AppString.minuteJp,

      AppString.morning: AppString.morningJp,
      AppString.lunch: AppString.lunchJp,
      AppString.evening: AppString.eveningJp,

      AppString.monday: AppString.mondayJp,
      AppString.tuesday: AppString.tuesdayJp,
      AppString.wednesday: AppString.wednesdayJp,
      AppString.thursday: AppString.thursdayJp,
      AppString.friday: AppString.fridayJp,
      AppString.saturday: AppString.saturdayJp,
      AppString.sunday: AppString.sundayJp,

      AppString.pillcCannelDescription: AppString.pillcCannelDescriptionJp,
      AppString.drinkPillAlram: AppString.drinkPillAlramJp,
      AppString.pillText: AppString.pillTextJp,
      AppString.timeToDrink: AppString.timeToDrinkJp,

      AppString.completeSetting: AppString.completeSettingJp,
    },
    'ko_KR': {
      AppString.beforeStart: AppString.beforeStartKr,
      AppString.plzSetting: AppString.plzSettingKr,
      AppString.back: AppString.backKr,
      AppString.selectGoalLevel: AppString.selectGoalLevelKr,
      AppString.doYouWantToAlert: AppString.doYouWantToAlertKr,

      AppString.cancelBtnTextTr: AppString.cancelBtnTextKr,
      AppString.plzAlarmTime: AppString.plzAlarmTimeKr,
      AppString.plzInputCollectTime: AppString.plzInputCollectTimeKr,
      AppString.hour: AppString.hourKr,
      AppString.minute: AppString.minuteKr,
      AppString.morning: AppString.morningKr,
      AppString.lunch: AppString.lunchKr,
      AppString.evening: AppString.eveningKr,

      AppString.monday: AppString.mondayKr,
      AppString.tuesday: AppString.tuesdayKr,
      AppString.wednesday: AppString.wednesdayKr,
      AppString.thursday: AppString.thursdayKr,
      AppString.friday: AppString.fridayKr,
      AppString.saturday: AppString.saturdayKr,
      AppString.sunday: AppString.sundayKr,

      AppString.pillcCannelDescription: AppString.pillcCannelDescriptionKr,
      AppString.drinkPillAlram: AppString.drinkPillAlramKr,
      AppString.pillText: AppString.pillTextKr,
      AppString.timeToDrink: AppString.timeToDrinkKr,

      AppString.completeSetting: AppString.completeSettingKr,
    },
  };
}

class AppString {
  static const appName = '종각 TOPIK';
  static const defaultCategory = "韓国語能力試験";
  static const String youHavePreQuizData = '과거 퀴즈를 본 경험이 있습니다.';
  static const String plzMoreChar = "以上に入力してください。";

  // Book
  static const String bookCtlHint = '単語帳名';

  static const String isCreated = "が作成されました。";
  static const String isDeleted = "が削除されました。";

  static const String savedWordText = "保存された単語：";
  static const String unit = '個';
  static const String word = '単語';
  static const String mean = '意味';
  static const String yomikata = '発音';

  static const String noRecordedData = "記録データがありません";

  static const doQuizAllMissedWords = "すべての単語でQUIZ";
  static const plzInputMore = "の以上を入力してください。";
  static const plzInputLess = "の以下を入力してください。";

  static const correctRate = "正答率";

  static String beforeStart = "beforeStart";
  static String beforeStartKr = "를 시작하기 전에\n";
  static String beforeStartJp = 'を始める前に\n';

  static String plzSetting = "plzSettingTr";
  static String plzSettingKr = "몇 가지 설정을 진행해주세요.";
  static String plzSettingJp = 'いくつか設定を行なってください。';

  static String back = "backTr";
  static String backKr = "뒤로";
  static String backJp = '前へ';

  static String selectGoalLevel = "selectGoalLevelTr";
  static String selectGoalLevelKr = "목표 하고 있는 TOPIK 레벨을 선택해주세요";
  static String selectGoalLevelJp = '前へ';

  static String doYouWantToAlert = "doYouWantToAlertTr";
  static String doYouWantToAlertKr = "알람 설정을 하시겠습니까 ?";
  static String doYouWantToAlertJp = '前へ';

  // pickTime
  static String cancelBtnTextTr = "cancelBtnTextTr";
  static String cancelBtnTextKr = '취소';
  static String cancelBtnTextJp = "取消";
  static String cancelBtnTextEn = "Cancel";

  static String plzAlarmTime = "plzAlarmTimeTr";
  static String plzAlarmTimeKr = "알림 시간을 입력해주세요";
  static String plzAlarmTimeJp = "アラーム時間を入力してください";
  static String plzAlarmTimeEn = "Please enter alarm time";

  static String plzInputCollectTime = "plzInputCollectTimeTr";
  static String plzInputCollectTimeKr = "올바른 형식의 시간을 입력해주세요";
  static String plzInputCollectTimeJp = "正しい形式の時間を入力してください";
  static String plzInputCollectTimeEn = "Please enter a valid format of time";

  static String hour = "timeTr";
  static String hourKr = '시';
  static String hourJp = "時";
  static String hourEn = "Time";

  static String minute = "minuteTr";
  static String minuteKr = '분';
  static String minuteJp = "分";
  static String minuteEn = "Minute";

  static String morning = "morningTr";
  static String morningKr = '아침';
  static String morningJp = "朝";
  static String morningEn = "Morning";

  static String lunch = "lunchTr";
  static String lunchKr = '점심';
  static String lunchJp = "昼";
  static String lunchEn = "Noon";

  static String evening = "eveningTr";
  static String eveningKr = '저녁';
  static String eveningJp = "夕";
  static String eveningEn = "Evening";

  static String monday = "mondayTr";
  static String mondayKr = "월";
  static String mondayJp = '月';
  static String mondayEn = "Mon";

  static String tuesday = "tuesdayTr";
  static String tuesdayKr = "화";
  static String tuesdayJp = '火';
  static String tuesdayEn = "Tues";

  static String wednesday = "wednesdayTr";
  static String wednesdayKr = "수";
  static String wednesdayJp = '水';
  static String wednesdayEn = "Wed";

  static String thursday = "thursdayTr";
  static String thursdayKr = "목";
  static String thursdayJp = '木';
  static String thursdayEn = "Thurs";

  static String friday = "fridayTr";
  static String fridayKr = "금";
  static String fridayJp = '金';
  static String fridayEn = "Fri";

  static String saturday = "saturdayTr";
  static String saturdayKr = "토";
  static String saturdayJp = '土';
  static String saturdayEn = "Sat";

  static String sunday = "sundayTr";
  static String sundayKr = "일";
  static String sundayJp = '日';
  static String sundayEn = "sun";

  static String pillcCannelDescription = 'pillcCannelDescriptiontr';
  static String pillcCannelDescriptionKr = '매주 특정 요일 및 시간에 알림을 받습니다';
  static String pillcCannelDescriptionJp = '毎週特定の曜日及び時間にアラームが鳴ります';
  static String pillcCannelDescriptionEn =
      "An alarm goes off every week on a particular day of the week and on a particular time";

  static String drinkPillAlram = 'drinkPillAlramtr';
  static String drinkPillAlramKr = '약 복용 시간';
  static String drinkPillAlramJp = '薬の服用の時間';
  static String drinkPillAlramEn = "Time for medication";

  static String completeSetting = 'completeSettingTr';
  static String completeSettingKr = '설정이 완료되었습니다.\n설정 페이지에서 변경하실 수 있습니다.';
  static String completeSettingJp = '設定が完了しました。\n設定ページより変更できます';
  static String completeSettingEn =
      "Setup is complete.\nYou can change it on the settings page";

  static String pillText = 'pillTexttr';
  static String pillTextKr = ' 약';
  static String pillTextJp = '薬';
  static String pillTextEn = " Medicine";

  static String timeToDrink = 'timeToDrinktr';
  static String timeToDrinkKr = '약 먹을 시간입니다!';
  static String timeToDrinkJp = '薬を飲む時間です！';
  static String timeToDrinkEn = "It's time to take the medicine!";
}
