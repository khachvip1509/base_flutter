import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constants.dart';

class Introduce extends StatelessWidget {
  const Introduce({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    final screenWidth = MediaQuery.of(context).size.width;

    // Tính số cột dựa trên kích thước màn hình
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
              _BasicItem(
                icon: Icons.temple_buddhist,
                title: 'JLPT là gì?',
                color: Color(0xFFEF767A),
              ),
              _BasicItem(
                icon: Icons.dashboard_customize,
                title: 'Cấu trúc đề thi',
                color: Color(0xFFFEBE7E),
              ),
              _BasicItem(
                icon: Icons.edit_document,
                title: 'Đăng ký thi',
                color: Color(0xFF6CC4A1),
              ),
              _BasicItem(
                icon: Icons.info_outline,
                title: 'Giới thiệu tiếng Nhật',
                color: Color(0xFF7AA5D2),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // ---------------------
          // PHẦN 2: Kiến thức cơ bản
          // ---------------------
          const Text(
            'Kiến thức cơ bản',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),

          _ResponsiveGrid(
            crossAxisCount: crossAxisCount,
            children: const [
              _BasicItem(
                icon: Icons.abc,
                title: 'Bảng chữ cái',
                color: Color(0xFF67C5B5),
              ),
              _BasicItem(
                icon: Icons.book,
                title: 'Mina no Nihongo 1\n(N5)',
                color: Color(0xFF6C84E0),
              ),
              _BasicItem(
                icon: Icons.menu_book,
                title: 'Mina no Nihongo 2\n(N5)',
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

//
// ✅ Widget item con
//
class _BasicItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _BasicItem({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}
