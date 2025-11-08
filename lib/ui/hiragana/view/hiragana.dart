import 'package:flutter/material.dart';
import 'package:untitled/utils/styles.dart';

import '../../../data/model/hiragana_model.dart';
import '../../../utils/app_constants.dart';
class HiraganaListPage extends StatelessWidget {
  final List<List<HiraganaItem>> hiraganaGroups = [
    [
      HiraganaItem(kana: 'あ', meaning: 'a'),
      HiraganaItem(kana: 'い', meaning: 'i'),
      HiraganaItem(kana: 'う', meaning: 'u'),
      HiraganaItem(kana: 'え', meaning: 'e'),
      HiraganaItem(kana: 'お', meaning: 'o'),
    ],
    [
      HiraganaItem(kana: 'か', meaning: 'ka'),
      HiraganaItem(kana: 'き', meaning: 'ki'),
      HiraganaItem(kana: 'く', meaning: 'ku'),
      HiraganaItem(kana: 'け', meaning: 'ke'),
      HiraganaItem(kana: 'こ', meaning: 'ko'),
    ],
    [
      HiraganaItem(kana: 'さ', meaning: 'sa'),
      HiraganaItem(kana: 'し', meaning: 'shi'),
      HiraganaItem(kana: 'す', meaning: 'su'),
      HiraganaItem(kana: 'せ', meaning: 'se'),
      HiraganaItem(kana: 'そ', meaning: 'so'),
    ],
    [
      HiraganaItem(kana: 'や', meaning: 'ya'),
      HiraganaItem(kana: 'ゆ', meaning: 'yu'),
      HiraganaItem(kana: 'よ', meaning: 'yo'),
    ],
    [
      HiraganaItem(kana: 'わ', meaning: 'wa'),
      HiraganaItem(kana: 'を', meaning: '(w)o'),
    ],
    [
      HiraganaItem(kana: 'ん', meaning: 'n'),
    ],
  ];

  final List<Color> pastelColors = [
    Colors.pink.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.teal.shade100,
  ];


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = 24.0;
    final spacing = 12.0;
    final maxItemPerRow = 5;
    final totalSpacing = spacing * (maxItemPerRow - 1);
    final itemWidth = (screenWidth - horizontalPadding - totalSpacing) / maxItemPerRow;

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.hiragana)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: ListView.builder(
          itemCount: hiraganaGroups.length,
          itemBuilder: (context, groupIndex) {
            final group = hiraganaGroups[groupIndex];
            final bgColor = pastelColors[groupIndex % pastelColors.length];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: group.map((item) {
                  return Container(
                    width: itemWidth,
                    height: itemWidth,
                    decoration: BoxDecoration(
                      color: bgColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.kana,
                          style: boldStyle,
                        ),
                        SizedBox(height: 4),
                        Text(
                          item.meaning,
                          style: normalStyle,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
