import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';
import '../../../common/presentation/bounce_widget.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const SectionTitle({Key? key, required this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: headline2.copyWith(color: AppColors.black),
          ),
          const Spacer(),
          Bounce(
            borderRadius: 8,
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'See All',
                    style: hint.copyWith(color: AppColors.blueText),
                  ),
                  const SizedBox(width: 12,),
                  SvgPicture.asset('assets/images/arrow_left.svg',
                    semanticsLabel: 'arrow_left',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}