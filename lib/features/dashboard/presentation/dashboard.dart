import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vega_innovattions_assignmen/core/presentation/bounce_widget.dart';
import 'package:vega_innovattions_assignmen/core/utils/colors.dart';

import '../../../core/utils/text_style.dart';
import 'widgets/news_slider.dart';
import 'widgets/search_bar.dart';
import 'widgets/section_title.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                30.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Expanded(child: DashboardSearchBar()),
                      20.horizontalSpace,
                      SvgPicture.asset('assets/images/notification_icon.svg',
                        semanticsLabel: 'notification_icon',
                      )
                    ],
                  ),
                ),
                24.verticalSpace,
                SectionTitle(
                  title: 'Breaking News',
                  onPressed: () {},
                ),
                const NewsSlider()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

