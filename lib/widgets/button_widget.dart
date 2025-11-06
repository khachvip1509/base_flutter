import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/app_constants.dart';
import '../utils/styles.dart';
// import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    Key? key,
    this.callback,
    this.name = "",
    this.width,
    this.color = AppColors.grey5A5A5A,
    this.radius = 8,
    this.icon,
    this.height = 40,
    this.sizeIcon = 12,
    this.textStyle = normalStyle,
    this.boderColor = Colors.transparent,
    this.boderWidth = 0,
    this.textColor = AppColors.whiteEEEEF4,
    this.enable = true,
  }) : super(key: key);
  VoidCallback? callback;
  Color color;
  Color textColor = AppColors.whiteEEEEF4;
  String name = "";
  double? width;
  double height = 40;
  double radius = 8;
  double sizeIcon = 12;
  String? icon;
  Color boderColor = Colors.transparent;
  double boderWidth = 0;
  TextStyle textStyle = normalStyle;
  bool enable = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (enable && callback != null) {
          callback!();
        }
      },
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: boderColor, width: boderWidth),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                SvgPicture.asset(
                  icon!,
                  width: sizeIcon,
                  height: sizeIcon,
                  fit: BoxFit.fitHeight,
                ),
              if (icon != null && name.isNotEmpty) const SizedBox(width: 6),
              if (name.isNotEmpty)
                Text(name.tr, style: textStyle.copyWith(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
