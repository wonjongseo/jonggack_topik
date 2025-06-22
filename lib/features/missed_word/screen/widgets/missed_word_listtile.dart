import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jonggack_topik/core/models/missed_word.dart';
import 'package:jonggack_topik/core/models/word.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';

class MissedWordListTIle extends StatelessWidget {
  const MissedWordListTIle({
    super.key,
    this.onTapMean,
    required this.onTap,
    required this.missedWord,
    required this.word,
    required this.isHidenMean,
  });
  final Function()? onTapMean;
  final Function() onTap;

  final TriedWord missedWord;
  final Word word;

  final bool isHidenMean;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 80,
      leading: Text(
        word.word,
        style: TextStyle(fontSize: SettingController.to.baseFS - 2),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTapMean,
            child: SizedBox(
              height: 30,
              child: Container(
                decoration:
                    isHidenMean ? BoxDecoration(color: Colors.grey) : null,
                child: Text(
                  word.mean,
                  style: TextStyle(
                    color: isHidenMean ? Colors.grey : null,
                    fontSize: SettingController.to.baseFS - 4,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            word.yomikata,
            style: TextStyle(fontSize: SettingController.to.baseFS - 4),
          ),
        ],
      ),
      // subtitle: ,
      onTap: onTap,
      trailing:
          missedWord.missCount == 0
              ? null
              : Text(
                '${missedWord.missCount}回',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: SettingController.to.baseFS - 5,
                ),
              ),
      // trailing: Column(
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     IconButton(
      //       style: IconButton.styleFrom(
      //         minimumSize: const Size(0, 0),
      //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //       ),
      //       onPressed: onTrailingTap,
      //       icon: Icon(FontAwesomeIcons.trash),
      //       iconSize: 16,
      //       color: Colors.redAccent,
      //     ),
      //     Text(
      //       '${missedWord.missCount}回',
      //       style: TextStyle(
      //         color: Colors.grey.shade600,
      //         fontSize: SettingController.to.baseFS - 5,
      //       ),
      //     ),
      //   ],
      // ),
      // isThreeLine: true,
    );
  }
}
