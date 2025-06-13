import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:jonggack_topik/core/repositories/setting_repository.dart';
import 'package:jonggack_topik/core/utils/app_constant.dart';

class AppReviewService {
  static final InAppReview _inAppReview = InAppReview.instance;
  static final appUsageCountBox = Hive.box<int>('usageCount');
  static final isReviewedBox = Hive.box<bool>('hasReviewed');

  static Future<void> checkReviewRequest() async {
    await _inAppReview.isAvailable();

    int usageCount =
        SettingRepository.getInt(AppConstant.countOfReiveRequestionKey) ?? 0;

    SettingRepository.setInt(
      AppConstant.countOfReiveRequestionKey,
      usageCount + 1,
    );

    bool hasReviewed =
        SettingRepository.getBool(AppConstant.hasReviewedKey) ?? false;

    if (!hasReviewed) {
      if (_shouldRequestReview(usageCount)) {
        await _requestReview();
      }
    }
  }

  static bool _shouldRequestReview(int count) {
    int n = 1;
    while (true) {
      int geometricTerm = n * (n + 1) * 5;
      if (count == geometricTerm) {
        return true;
      } else if (count < geometricTerm) {
        return false;
      }
      n++;
    }
  }

  static Future<void> _requestReview() async {
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
      await SettingRepository.setBool(AppConstant.hasReviewedKey, true);
    }
  }
}
