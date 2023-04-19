import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/text_style.dart';

class DashboardSearchBar extends StatelessWidget {
  const DashboardSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Frame29Widget - FRAME - HORIZONTAL
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: const Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(
          color: const Color.fromRGBO(239, 240, 250, 1),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 35,
              child: TextFormField(
                controller: TextEditingController(),
                textAlign: TextAlign.left,
                style: hint.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Dogecoin to the Moon...',
                  hintStyle: hint.copyWith(color: AppColors.grayHint.withOpacity(0.4)),
                  contentPadding: const EdgeInsets.only(bottom: 12)
                ),
              ),
            ),
          ),
          SvgPicture.asset('assets/images/search_icon.svg',
            semanticsLabel: 'search_icon',
          ),
        ],
      ),
    );
  }
}