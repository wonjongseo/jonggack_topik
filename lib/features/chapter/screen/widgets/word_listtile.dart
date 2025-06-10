import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class WordListTile extends StatelessWidget {
  const WordListTile({
    super.key,
    this.onTapMean,
    required this.onTap,
    required this.word,
    required this.isHidenMean,
    required this.trailing,
  });
  final Function()? onTapMean;
  final Function() onTap;
  final Word word;
  final bool isHidenMean;
  final Widget trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 80,
      leading: Text(
        word.word,
        style: TextStyle(fontSize: SettingController.to.baseFS),
      ),
      title: InkWell(
        onTap: onTapMean,
        child: SizedBox(
          height: 30,
          child: Container(
            decoration: isHidenMean ? BoxDecoration(color: Colors.grey) : null,
            child: Text(
              word.mean,
              style: TextStyle(
                fontSize: SettingController.to.baseFS - 2,
                color: isHidenMean ? Colors.grey : null,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      subtitle: SizedBox(
        child: Text(
          word.yomikata,
          style: TextStyle(fontSize: SettingController.to.baseFS - 3),
        ),
      ),
      onTap: () => onTap(),
      trailing: trailing,
      isThreeLine: true,
    );
  }
}
