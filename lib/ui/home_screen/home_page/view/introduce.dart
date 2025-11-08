import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constants.dart';

import '../../../hiragana/view/hiragana.dart';
import 'basic_item_home.dart';

class Introduce extends StatelessWidget {
  const Introduce({super.key});

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
          const SizedBox(height: 12),

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
          const SizedBox(height: 15),

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
                    MaterialPageRoute(builder: (context) => HiraganaListPage()),
                  );
                },
              ),
              const BasicItem(
                icon: Icons.book,
                title: AppStrings.amDuc,
                color: Color(0xFF6C84E0),
              ),
              const BasicItem(
                icon: Icons.menu_book,
                title: AppStrings.amBanDuc,
                color: Color(0xFF6C5BD0),
              ),
            ],
          ),

          const SizedBox(height: 28),
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
