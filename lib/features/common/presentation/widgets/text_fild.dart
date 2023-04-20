import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';

Widget textField({
  required String hintTxt,
  required TextEditingController controller,
  bool isObs = false,
  TextInputType? keyBordType,
  FocusNode? focusNode,
  void Function(String text)? onChanged,
  void Function(String text)? onSubmitted,
  bool? isValid,
  String? errorText,
  TextInputType? keyboardType,
  Iterable<String>? autofillHints,
  TextInputAction? textInputAction,
  TextCapitalization? textCapitalization,
}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.blackTextField,
          borderRadius: BorderRadius.circular(20.0),
          border : Border.all(
            color: (isValid == null || isValid)? Colors.transparent : AppColors.red,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 250.w,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                obscureText: isObs,
                keyboardType: keyBordType,
                focusNode: focusNode,
                autofillHints: autofillHints,
                textInputAction: textInputAction,
                textCapitalization: textCapitalization?? TextCapitalization.none,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintTxt,
                  hintStyle: hintStyle,
                ),
                style: headline3.copyWith(color: AppColors.white),
                onFieldSubmitted: onSubmitted,
                onChanged: onChanged,
              ),
            ),
            if(isValid != null)
              Icon(
                isValid? Icons.done : Icons.info_outline,
                color: isValid? AppColors.green : AppColors.red,
                size: 20,
              )
          ],
        ),
      ),
      Positioned(
        bottom: -6,
        left: 40,
        child: Text(
          errorText??'',
          style: formValidation,
        ),
      )
    ],
  );
}
