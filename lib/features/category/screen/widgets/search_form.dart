import 'package:flutter/material.dart';
import 'package:jonggack_topik/core/utils/app_color.dart';
import 'package:jonggack_topik/theme.dart';

class SeacrhForm extends StatelessWidget {
  const SeacrhForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Card(
                child: Form(
                  child: TextFormField(
                    keyboardType: TextInputType.text,

                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.japaneseFont,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: ' 韓国語検索...',
                      hintStyle: TextStyle(fontSize: 14),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                right: 10,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        color:
                            true
                                ? Colors.grey.shade300
                                : AppColors.mainBordColor,
                        child: InkWell(
                          onTap: () async {},
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.search,
                              size: 30,
                              color:
                                  true ? Colors.grey.shade100 : Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
