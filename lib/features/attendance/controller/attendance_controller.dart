import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jonggack_topik/core/logger/logger_service.dart';
import 'package:jonggack_topik/core/models/attendance_date.dart';
import 'package:jonggack_topik/core/repositories/hive_repository.dart';

class AttendanceController extends GetxController {
  final attendances = <DateTime>[].obs;

  @override
  void onInit() {
    getAllAttendances();
    super.onInit();
  }

  void getAllAttendances() {
    final list = AttendanceDateRepository.getAllDates();
    list.sort((a, b) => a.compareTo(b));
    attendances.assignAll(list);
  }
}

class AttendanceDateRepository {
  static final attendanceRepo = Get.find<HiveRepository<AttendanceDate>>();

  static Future<void> addDate(DateTime date) async {
    final attendances = attendanceRepo.getAll();
    final key = _keyFor(date);
    if (!attendances.any((e) => _isSameDay(e.date, date))) {
      await attendanceRepo.put(key, AttendanceDate(date));
      LogManager.info('출석체크 키: $key');
    }
  }

  static List<DateTime> getAllDates() {
    final attendances = attendanceRepo.getAll();
    return attendances.map((e) => e.date).toList();
  }

  static String _keyFor(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
