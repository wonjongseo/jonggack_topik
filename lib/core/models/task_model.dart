import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:jonggack_topik/core/models/notification_model.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: HK.taskModelHiveId)
class TaskModel {
  @HiveField(0)
  String taskName;
  @HiveField(1)
  DateTime taskDate;
  @HiveField(2)
  late String id;
  @HiveField(3)
  late int createdAt;
  @HiveField(4)
  List<NotificationModel> notifications;
  @HiveField(5, defaultValue: false)
  bool isRegular;
  TaskModel({
    required this.taskName,
    required this.taskDate,
    required this.notifications,
    this.isRegular = false,
  }) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'TaskModel(taskName: $taskName, taskDate: $taskDate, id: $id, createdAt: $createdAt, notifications: $notifications, isRegular: $isRegular)';
  }
}

//userController.userModel!.tasks![9].notifications
