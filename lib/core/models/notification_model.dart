import 'package:hive/hive.dart';
import 'package:jonggack_topik/core/constant/hive_keys.dart';
import 'package:uuid/uuid.dart';

part 'notification_model.g.dart';

@HiveType(typeId: HK.notificationModelHiveId)
class NotificationModel extends HiveObject {
  static const String boxKey = HK.notificationModelBoxKey;
  @HiveField(0)
  final DateTime notiDateTime;
  @HiveField(1)
  final int alermId;
  @HiveField(2)
  late String id;
  @HiveField(3)
  late int createdAt;

  NotificationModel({required this.notiDateTime, required this.alermId}) {
    id = const Uuid().v4();
    createdAt = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'Notification(dateTime: $notiDateTime, alermId: $alermId, id: $id, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.notiDateTime == notiDateTime &&
        other.alermId == alermId &&
        other.id == id &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return notiDateTime.hashCode ^
        alermId.hashCode ^
        id.hashCode ^
        createdAt.hashCode;
  }
}
