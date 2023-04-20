import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  const ErrorDisplayWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(15, 2, 15, 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.whiteText,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: AppColors.brown)
      ),
      child: Text(
        message,
        style: hintStyle.copyWith(color: AppColors.brown, fontWeight: FontWeight.w400),
      ),
    );
  }
}
