import 'dart:async';
import 'package:flutter/material.dart';
import 'image_info.dart';

class HeroLayoutCard extends StatefulWidget {
  const HeroLayoutCard({super.key});

  @override
  State<HeroLayoutCard> createState() => _HeroLayoutCardState();
}

class _HeroLayoutCardState extends State<HeroLayoutCard>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  int _currentIndex = 0;
  late final Timer _timer;

  late final AnimationController _bounceController;
  late final Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.75,
      initialPage: 1000 * ImageInformation.values.length,
    );
    _currentIndex = _pageController.initialPage % ImageInformation.values.length;

    // Auto-play
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    // Nhún trung tâm
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _bounceAnimation =
        Tween<double>(begin: 1.0, end: 1.05).animate(CurvedAnimation(
          parent: _bounceController,
          curve: Curves.easeInOut,
        ));
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Column(
      children: [
        SizedBox(
          height: height / 5,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index % ImageInformation.values.length;
              });
            },
            itemBuilder: (context, index) {
              final i = index % ImageInformation.values.length;
              final image = ImageInformation.values[i];

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value =
                        ((_pageController.page ?? _pageController.initialPage)
                            .toDouble()) -
                            index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  }

                  final isCenter = i == _currentIndex;
                  final scale = isCenter ? _bounceAnimation.value : value;
                  final opacity = isCenter ? 1.0 : 0.5;

                  // 3D rotation
                  final rotationY = value * 0.25; // ~14° nghiêng

                  // Parallax offset
                  final parallaxOffset = 40 * (1 - value);

                  // Shadow cho 3D
                  final shadowBlur = isCenter ? 12.0 : 6.0;
                  final shadowOpacity = isCenter ? 0.3 : 0.15;

                  return Opacity(
                    opacity: opacity,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(parallaxOffset * (i < _currentIndex ? -1 : 1))
                        ..rotateY(rotationY),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: AnimatedScale(
                          scale: scale,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(shadowOpacity),
                                      blurRadius: shadowBlur,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      isCenter
                                          ? Colors.transparent
                                          : Colors.black.withOpacity(0.3),
                                      BlendMode.darken,
                                    ),
                                    child: Image.network(
                                      'https://flutter.github.io/assets-for-api-docs/assets/material/${image.url}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(16)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7),
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AnimatedDefaultTextStyle(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isCenter ? 20 : 16,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black54,
                                              blurRadius: isCenter ? 8 : 4,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Text(image.title),
                                      ),
                                      const SizedBox(height: 4),
                                      AnimatedDefaultTextStyle(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isCenter ? 14 : 12,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black54,
                                              blurRadius: isCenter ? 6 : 3,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(image.subtitle),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Indicator chấm
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            ImageInformation.values.length,
                (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? Colors.blue
                    : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
