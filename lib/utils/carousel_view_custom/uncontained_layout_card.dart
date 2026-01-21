import 'package:flutter/material.dart';

class UncontainedLayoutCard extends StatefulWidget {
  final List<String> items;
  final int offsetColor;
  final void Function()? onUserScroll;

  const UncontainedLayoutCard({
    super.key,
    required this.items,
    this.offsetColor = 0,
    this.onUserScroll,
  });

  @override
  State<UncontainedLayoutCard> createState() => UncontainedLayoutCardState();
}

class UncontainedLayoutCardState extends State<UncontainedLayoutCard> {
  late final PageController _controller;
  int _currentIndex = 0;
  bool _isResetting = false;

  static const double _viewportFraction = 0.3;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: _viewportFraction);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 🔥 GIỮ NGUYÊN – RESET VỀ ITEM ĐẦU
  void resetToStart() {
    if (!mounted || _currentIndex == 0 || !_controller.hasClients) return;

    _isResetting = true;
    _controller
        .animateToPage(
      0,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    )
        .then((_) {
      if (!mounted) return;
      _isResetting = false;
      setState(() => _currentIndex = 0);
    });
  }

  void _onPageChanged(int index) {
    if (!mounted) return;
    setState(() => _currentIndex = index);
    if (!_isResetting) widget.onUserScroll?.call();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * _viewportFraction - 12; // 🔥 CHỐT

    return SizedBox(
      height: 96,
      child: PageView.builder(
        padEnds: false,
        controller: _controller,
        onPageChanged: _onPageChanged,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final title = widget.items[index];

          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scale = 1.0;

              if (_controller.position.haveDimensions) {
                final page = _controller.page ?? _currentIndex.toDouble();
                final distance = (page - index).abs();
                scale = (1 - distance * 0.2).clamp(0.88, 1.0);
              }

              return Transform.scale(
                scale: scale,
                alignment: Alignment.centerLeft,
                child: child,
              );
            },
            child: _buildCard(title, index, cardWidth),
          );
        },
      ),
    );
  }

  Widget _buildCard(String title, int index, double width) {
    final isActive = index == _currentIndex;

    return SizedBox(
      width: width, // 🔥 KHÔNG BAO GIỜ DÀI NỮA
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.only(
          right: 8, // 🔥 KHOẢNG CÁCH GIỮA ITEM
          top: isActive ? 6 : 14,
          bottom: isActive ? 6 : 14,
        ),
        decoration: BoxDecoration(
          color: Colors
              .primaries[(index + widget.offsetColor) % Colors.primaries.length]
              .withOpacity(0.65),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            if (isActive)
              BoxShadow(
                blurRadius: 14,
                offset: const Offset(0, 6),
                color: Colors.black.withOpacity(0.25),
              ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
