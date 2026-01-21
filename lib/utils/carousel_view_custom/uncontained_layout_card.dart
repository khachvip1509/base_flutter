import 'package:flutter/material.dart';

class UncontainedLayoutCard extends StatelessWidget {
  final List<String> items;
  final int offsetColor;

  UncontainedLayoutCard({super.key, required this.items, this.offsetColor = 0});

  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 100),
      child: CarouselView(
        itemExtent: 200,
        shrinkExtent: 200,
        children: List<Widget>.generate(items.length, (int index) {
          final title = items[index];

          return ColoredBox(
            color: Colors
                .primaries[(index + offsetColor) % Colors.primaries.length]
                .withOpacity(0.5),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1.2, // giãn dòng đẹp hơn
                  ),
                  softWrap: true,
                  // ✅ cho phép wrap
                  maxLines: 2,
                  // ✅ tối đa 2 dòng
                  overflow: TextOverflow.visible, // ✅ không cắt chữ
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
