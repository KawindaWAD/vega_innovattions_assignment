import 'package:flutter/material.dart';
import 'package:vega_innovattions_assignmen/core/functions/extentions/string_extentions.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../bounce_widget.dart';

class CategoryChip extends StatelessWidget {
  final String name;
  final Function() onTap;
  final bool isSelected;
  const CategoryChip({Key? key, required this.name, required this.onTap, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      borderRadius: 16,
      child: Container(
        height: 32.0,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border : Border.all(
            color: isSelected? const Color(0xFFFF8086) : AppColors.outline,
            width: 1,
          ),
          gradient : isSelected? const LinearGradient(
              begin: Alignment(0.0,0.5),
              end: Alignment(1,0.5),
              colors: [AppColors.red, Color(0xFFFF8086)]
          ) : null,
          color: isSelected? null : AppColors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name.capitalize(),
              style: hint.copyWith(color: isSelected? AppColors.white : AppColors.brown),
            )
          ],
        ),
      ),
    );
  }
}
