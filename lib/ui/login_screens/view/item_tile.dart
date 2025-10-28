import 'package:flutter/material.dart';

import '../../../domain/model/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;

  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          item.id.toString(),
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
