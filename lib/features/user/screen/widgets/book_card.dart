import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:jonggack_topik/core/models/book.dart';
import 'package:jonggack_topik/core/utils/app_string.dart';
import 'package:jonggack_topik/features/setting/controller/setting_controller.dart';
import 'package:jonggack_topik/theme.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    this.teCtl,
    required this.book,
    required this.deleteBook,
    required this.updateBook,
  });

  final Book book;
  final Function(Book) deleteBook;
  final Function(Book) updateBook;
  final TextEditingController? teCtl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    book.title,
                    style: TextStyle(
                      fontSize: SettingController.to.baseFS + 6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (book.bookNum != 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => deleteBook(book),
                        icon: Icon(FontAwesomeIcons.trash, size: 18),
                      ),
                      SizedBox(width: 10),

                      IconButton(
                        onPressed: () => updateBook(book),
                        icon: Icon(FontAwesomeIcons.pen, size: 18),
                      ),
                    ],
                  ),
              ],
            ),

            Divider(),
            SizedBox(height: 10),
            Text(
              '${AppString.savedWordText.tr}${book.wordIds.length}${AppString.unit.tr}',
              style: TextStyle(fontFamily: AppFonts.zenMaruGothic),
            ),
          ],
        ),
      ),
    );
  }
}
