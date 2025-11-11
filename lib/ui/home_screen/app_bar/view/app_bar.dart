import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app_routers/screens.dart';

import '../../../../../../utils/app_constants.dart';

class MenuLeading extends StatefulWidget {
  const MenuLeading({super.key});

  @override
  State<MenuLeading> createState() => _MenuLeadingState();
}

class _MenuLeadingState extends State<MenuLeading>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlay;
  late AnimationController _controller;

  final items = const [
    {'label': AppStrings.luyenTap, 'icon': Icons.home},
    {'label': AppStrings.loTrinh, 'icon': Icons.rocket},
    {'label': AppStrings.thi, 'icon': Icons.star},
    {'label': AppStrings.nangCap, 'icon': Icons.diamond},
    {'label': AppStrings.caiDat, 'icon': Icons.settings},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  void _toggleMenu() {
    if (_overlay != null) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    final overlay = Overlay.of(context);
    final RenderBox box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);

    _overlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // nền blur
          GestureDetector(
            onTap: _closeMenu,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black26.withOpacity(0.2)),
            ),
          ),
          Positioned(
            left: offset.dx + 8,
            top: offset.dy + box.size.height + 6,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOutBack,
              ),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: items.map((e) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          _closeMenu();
                          if (e['label'] == AppStrings.luyenTap) {
                            Get.toNamed(Home.home);
                          }

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                e['icon'] as IconData,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                e['label'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlay!);
    _controller.forward();
  }

  void _closeMenu() {
    _controller.reverse().then((_) {
      _overlay?.remove();
      _overlay = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(animation: _controller, onPressed: _toggleMenu);
  }
}

class AnimatedIconButton extends StatelessWidget {
  final AnimationController animation;
  final VoidCallback onPressed;

  const AnimatedIconButton({
    super.key,
    required this.animation,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: animation,
        color: Colors.white,
        size: AppNumbs.sizeAvt/1.5,
      ),
      tooltip: AppStrings.menu,
      onPressed: onPressed,
    );
  }
}
