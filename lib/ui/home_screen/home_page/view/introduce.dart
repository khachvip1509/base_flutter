import 'package:flutter/material.dart';
import 'package:untitled/ui/quiz_screen/view/flash_card.dart';
import 'package:untitled/utils/app_constants.dart';

import '../../../../utils/carousel_view_custom/normal_layout_card.dart';
import '../../../../utils/carousel_view_custom/uncontained_layout_card.dart';
import '../../../hiragana/view/hiragana.dart';
import 'basic_item_home.dart';

class Introduce extends StatefulWidget {
  const Introduce({super.key});

  @override
  State<Introduce> createState() => _IntroduceState();
}

class _IntroduceState extends State<Introduce> {
  final GlobalKey<UncontainedLayoutCardState> _booksKey =
  GlobalKey<UncontainedLayoutCardState>();

  final GlobalKey<UncontainedLayoutCardState> _kanjiKey1 =
  GlobalKey<UncontainedLayoutCardState>();

  final GlobalKey<UncontainedLayoutCardState> _kanjiKey2 =
  GlobalKey<UncontainedLayoutCardState>();

  void _onAnyCarouselScroll(GlobalKey activeKey) {
    if (activeKey != _booksKey) {
      _booksKey.currentState?.resetToStart();
    }
    if (activeKey != _kanjiKey1) {
      _kanjiKey1.currentState?.resetToStart();
    }
    if (activeKey != _kanjiKey2) {
      _kanjiKey2.currentState?.resetToStart();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount;
    if (screenWidth < 600) {
      crossAxisCount = 2; // Mobile
    } else if (screenWidth < 900) {
      crossAxisCount = 4; // Tablet
    } else {
      crossAxisCount = 6; // Desktop
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------------
          // PHẦN 1: Giới thiệu chung
          // ---------------------
          const Text(
            AppStrings.gioiThieuChung,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _ResponsiveGrid(
            crossAxisCount: crossAxisCount,
            children: const [
              BasicItem(
                icon: Icons.temple_buddhist,
                title: AppStrings.jlpt,
                color: Color(0xFFEF767A),
              ),
              BasicItem(
                icon: Icons.dashboard_customize,
                title: AppStrings.cauTrucDeThi,
                color: Color(0xFFFEBE7E),
              ),
              BasicItem(
                icon: Icons.edit_document,
                title: AppStrings.dangKyThi,
                color: Color(0xFF6CC4A1),
              ),
              BasicItem(
                icon: Icons.info_outline,
                title: AppStrings.gioiThieuTiengNhat,
                color: Color(0xFF7AA5D2),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // ---------------------
          // PHẦN 2: Kiến thức cơ bản
          // ---------------------
          const Text(
            AppStrings.kienThucCoBan,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _ResponsiveGrid(
            crossAxisCount: crossAxisCount,
            children: [
              BasicItem(
                icon: Icons.abc,
                title: AppStrings.bangChuCai,
                color: const Color(0xFF67C5B5),
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HiraganaPage()),
                  );
                },
              ),
              BasicItem(
                icon: Icons.book,
                title: AppStrings.amDuc,
                color: const Color(0xFF6C84E0),
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlashCardScreen()),
                  );
                },
              ),
              const BasicItem(
                icon: Icons.menu_book,
                title: AppStrings.amBanDuc,
                color: Color(0xFF6C5BD0),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // ---------------------
          // PHẦN 3: Mỗi ngày 1 chữ Kanji
          // ---------------------
          const Text(
            AppStrings.moiNgayMotTuKanji,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE8F0FF), Color(0xFFF3F6FF)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "辺",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text("BIÊN"),
                      SizedBox(height: 4),
                      Text("xung quanh, vùng lân cận"),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.brush, size: 36, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ---------------------
          // PHẦN 4: Từ vựng theo Chủ Đề
          // ---------------------
          const Text(
            AppStrings.tuVungTheoChuDe,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          NormalLayoutCard(),
          const SizedBox(height: 32),

          // ---------------------
          // PHẦN 5: Từ vựng theo sách tiếng nhật
          // ---------------------
          const Text(
            AppStrings.tuVungTheoSachTiengNhat,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          UncontainedLayoutCard(
            key: _booksKey,
            items: AppStrings.books,
            onUserScroll: () => _onAnyCarouselScroll(_booksKey),
            onItemTap: (index,title){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlashCardScreen()),
              );
            },
          ),

          const SizedBox(height: 16),

          // ---------------------
          // PHẦN 6: Kanji
          // ---------------------
          const Text(
            AppStrings.kanji,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          UncontainedLayoutCard(
            key: _kanjiKey1,
            items: AppStrings.kanjiTopic,
            offsetColor: 5,
            onUserScroll: () => _onAnyCarouselScroll(_kanjiKey1),
            onItemTap: (index,title){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlashCardScreen()),
              );
            },
          ),

          const SizedBox(height: 16),
          // ---------------------
          // PHẦN 7: Kanji
          // ---------------------
          const Text(
            AppStrings.kanji,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          UncontainedLayoutCard(
            key: _kanjiKey2,
            items: AppStrings.kanjiTopic,
            offsetColor: 10,
            onUserScroll: () => _onAnyCarouselScroll(_kanjiKey2),
            onItemTap: (index,title){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlashCardScreen()),
              );
            },
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

//
// ✅ Widget Grid tùy biến cho responsive layout
//
class _ResponsiveGrid extends StatelessWidget {
  final int crossAxisCount;
  final List<Widget> children;

  const _ResponsiveGrid({required this.crossAxisCount, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Dùng Wrap để dễ co giãn
        final itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

        return Wrap(
          spacing: 16, // khoảng cách ngang
          runSpacing: 24, // khoảng cách dọc
          children: children
              .map(
                (child) => SizedBox(
                  width: itemWidth,
                  child: Center(child: child),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
