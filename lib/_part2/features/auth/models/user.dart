import 'package:hive/hive.dart';
import 'package:jonggack_topik/_part2/core/constant/hive_keys.dart';

part 'user.g.dart';

@HiveType(typeId: HK.userTypeID)
class User {
  static String boxKey = HK.userBoxKey;

  @HiveField(0, defaultValue: false)
  bool isPremieum = false;
}
