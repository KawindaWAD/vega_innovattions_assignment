import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';

changeStatusBar(bool isHide) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: isHide? Colors.transparent : AppColors.white,
      statusBarIconBrightness: isHide? Brightness.light : Brightness.dark,
    ),
  );
}