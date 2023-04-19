import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vega_innovattions_assignmen/core/presentation/bounce_widget.dart';

import '../../utils/colors.dart';
import '../../utils/text_style.dart';

class MainButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color? txtColor;
  final Color? btnColor1;
  final Color? btnColor2;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool isLoading;
  const MainButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.txtColor,
    this.btnColor1,
    this.btnColor2,
    this.height,
    this.width,
    this.borderRadius,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      borderRadius: borderRadius?? 24,
      child: Container(
        height: height?? 48.0,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius?? 24),
          border : Border.all(
            color: btnColor1?? const Color(0xFFFF8086),
            width: 1,
          ),
          gradient : LinearGradient(
              begin: const Alignment(0.0,0.5),
              end: const Alignment(1,0.5),
              colors: [btnColor1?? AppColors.red, const Color(0xFFFF8086)]
          ),
        ),
        child: isLoading? const Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          ),
        ) : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: txtColor != null
                  ? headline2.copyWith(color: txtColor)
                  : headline2,
            )
          ],
        ),
      ),
    );
  }
}