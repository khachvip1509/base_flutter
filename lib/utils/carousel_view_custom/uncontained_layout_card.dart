import 'package:flutter/material.dart';

class UncontainedLayoutCard extends StatelessWidget {
  UncontainedLayoutCard({super.key});

  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: CarouselView(
        itemExtent: 330,
        shrinkExtent: 200,
        children: List<Widget>.generate(20, (int index) {
          return ColoredBox(
            color: Colors.primaries[index % Colors.primaries.length]
                .withOpacity(0.5),
            child: Center(
              child: Text(
                'Show $index',
                style: const TextStyle(color: Colors.white, fontSize: 20),
                overflow: TextOverflow.clip,
                softWrap: false,
              ),
            ),
          );
        }),
      ),
    );
  }
}
