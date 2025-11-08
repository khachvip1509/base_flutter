import 'package:flutter/material.dart';

import 'app_constants.dart';

const fontFamilyMain = "Helveticaneue";

const paddingLeftRight = EdgeInsets.only(left: 16, right: 16);

const fontSizeNomal = 16.0;
const fontSizeNomalValidate = 13.0;
const fontSizeBold = 18.0;
const fontSizeBoldHeaderBar = 18.0;

const headerStyle = TextStyle(
  fontSize: fontSizeBoldHeaderBar,
  fontWeight: FontWeight.bold,
);

const normalStyleValidate = TextStyle(
  fontSize: fontSizeNomalValidate,
  fontFamily: fontFamilyMain,
  fontWeight: FontWeight.w200,
  color: AppColors.orangeFFD09D,
);

const normalStyle = TextStyle(
  fontSize: fontSizeNomal,
  fontFamily: fontFamilyMain,
  fontWeight: FontWeight.w400,
  color: AppColors.green009438,
);

const boldStyle = TextStyle(
  fontSize: fontSizeBold,
  fontFamily: fontFamilyMain,
  fontWeight: FontWeight.bold,
  color: AppColors.black000000,
);

const nomalDecoration = BoxDecoration(
  color: AppColors.grey5A5A5A,
  borderRadius: BorderRadius.all(Radius.circular(8)),
);
