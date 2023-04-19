import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import '../utils/text_style.dart';

class CustomFlushBar {
  static Flushbar primary(
      {required BuildContext context, required String message, String? title, Duration duration = const Duration(seconds: 3)}) {
    return Flushbar(
      duration: duration,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      messageText: Text(
        message,
        style:  title != null? headline3 : headline3.copyWith(fontSize: 17),
      ),
      titleText: title != null? Text(
        title,
        style: headline2,
      ) : null,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      borderRadius: BorderRadius.circular(15),
      leftBarIndicatorColor: AppColors.red,
      boxShadows: [BoxShadow(color: AppColors.red.withOpacity(0.5), offset: const Offset(0.0, 2.0), blurRadius: 3.0,)],
      backgroundColor: AppColors.black.withOpacity(0.8),
      icon: const Icon(
        Icons.info_outline,
        color: AppColors.red,
      ),
    )..show(context);
  }
}