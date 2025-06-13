import 'package:jonggack_topik/core/repositories/setting_repository.dart';

class RunMonthlyTaskService {
  static bool checkAndRunMonthlyTask() {
    final lastRunStr = SettingRepository.getString('lastMonthlyRun');
    final now = DateTime.now();

    bool shouldRun = false;
    if (lastRunStr == null) {
      // 한 번도 실행된 적 없으니 실행
      shouldRun = true;
    } else {
      final lastRun = DateTime.parse(lastRunStr);
      // 년이 바뀌었거나, 같은 해에서 월이 지났다면 실행
      if (now.year > lastRun.year ||
          (now.year == lastRun.year && now.month > lastRun.month)) {
        shouldRun = true;
      }
    }

    if (shouldRun) {
      SettingRepository.setString('lastMonthlyRun', now.toIso8601String());
    }
    return shouldRun;
  }
}
