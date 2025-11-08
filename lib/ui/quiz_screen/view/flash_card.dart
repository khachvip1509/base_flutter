import 'package:flutter/material.dart';

class FlashcardScreen extends StatelessWidget {
  final List<Map<String, String>> cards = [
    {'front': '水', 'back': 'Mizu - Nước'},
    {'front': '火', 'back': 'Hi - Lửa'},
    {'front': '木', 'back': 'Ki - Cây'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcard Kanji')),
      body: PageView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Center(
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Text(card['back']!, style: const TextStyle(fontSize: 24)),
                ),
              ),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(24),
                child: Center(
                  child: Text(card['front']!, style: const TextStyle(fontSize: 48)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}