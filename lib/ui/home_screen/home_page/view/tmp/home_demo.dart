import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  Widget _buildCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userName = 'Học viên'; // Có thể lấy từ profile hoặc auth

    return Scaffold(
      appBar: AppBar(
        title: const Text('Japanese Learning App'), // Japanese Learning App
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.toNamed('/settings');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Hello、$userName さん！', // Hello, [user]!
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          _buildCard(
            icon: Icons.text_fields,
            title: 'ひらがな (Hiragana)',
            onTap: () => Get.toNamed('/hiragana'),
          ),
          _buildCard(
            icon: Icons.text_format,
            title: 'カタカナ (Katakana)',
            onTap: () => Get.toNamed('/katakana'),
          ),
          _buildCard(
            icon: Icons.grid_view,
            title: '漢字 (Kanji)',
            onTap: () => Get.toNamed('/kanji'),
          ),
          _buildCard(
            icon: Icons.book,
            title: '語彙 (Từ vựng)',
            onTap: () => Get.toNamed('/vocabulary'),
          ),
          _buildCard(
            icon: Icons.rule,
            title: '文法 (Ngữ pháp)',
            onTap: () => Get.toNamed('/grammar'),
          ),
          _buildCard(
            icon: Icons.quiz,
            title: 'テスト (Kiểm tra)',
            onTap: () => Get.toNamed('/quiz'),
          ),
        ],
      ),
    );
  }
}
