import 'package:flutter/material.dart';

import 'image_info.dart';

class HeroLayoutCard extends StatelessWidget {
  HeroLayoutCard({super.key});
  final CarouselController controller = CarouselController(initialItem: 1);
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return  ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height / 5),
      child: CarouselView.weighted(
        controller: controller,
        itemSnapping: true,
        flexWeights: const <int>[1, 7, 1],
        children: ImageInformation.values.map((ImageInformation image) {
          return Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              ClipRect(
                child: OverflowBox(
                  maxWidth: width * 7 / 8,
                  minWidth: width * 7 / 8,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/material/${image.url}',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      image.title,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      image.subtitle,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    )
    ;
  }
}
