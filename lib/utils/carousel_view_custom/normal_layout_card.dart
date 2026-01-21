import 'package:flutter/material.dart';

import 'card_info.dart';

class NormalLayoutCard extends StatelessWidget {
  NormalLayoutCard({super.key});

  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height / 12),
        child: CarouselView.weighted(
          flexWeights: const <int>[3, 3, 3, 2, 1],
          consumeMaxWeight: false,
          children: CardInfo.values.map((CardInfo info) {
            return ColoredBox(
              color: info.backgroundColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(info.icon, color: info.color, size: 32.0),
                    Text(
                      info.label,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
