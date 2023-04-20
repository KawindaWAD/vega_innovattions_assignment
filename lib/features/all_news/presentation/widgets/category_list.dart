import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vega_innovattions_assignmen/core/utils/colors.dart';
import 'package:vega_innovattions_assignmen/features/common/presentation/bounce_widget.dart';

import '../../../../core/utils/const/const.dart';
import '../../../common/presentation/widgets/category_chip.dart';
import '../../../common/presentation/widgets/main_button.dart';
import '../bloc/all_news/all_news_bloc.dart';
import 'filter_chip.dart';

class ChipList extends StatelessWidget {
  const ChipList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: BlocSelector<AllNewsBloc, AllNewsState, String>(
        selector: (state) {
          return state.selectedCategory;
        },
        builder: (context, selectedCategory) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            scrollDirection: Axis.horizontal,
            itemCount: categoryStringList.length + 2,
            itemBuilder: (context, index) {
              if(index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AdvancedFilterChip(
                    name: 'Filter',
                    isSelected: false,
                    onTap: () {
                      _viewFilters(context);
                    },
                  ),
                );
              }
              if(index == 1) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CategoryChip(
                    name: 'All',
                    isSelected: selectedCategory == 'all',
                    onTap: () {
                      context.read<AllNewsBloc>().add(const CategoryChanged(categoryName: 'all'));
                    },
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CategoryChip(
                  name: categoryStringList.elementAt(index-2),
                  isSelected: selectedCategory == categoryStringList.elementAt(index-2),
                  onTap: () {
                    context.read<AllNewsBloc>().add(CategoryChanged(categoryName: categoryStringList.elementAt(index-2)));
                  },
                ),
              );
            },
          );
        },
      )
      ,
    );
  }

  // Show Filters as a bottom sheet
  void _viewFilters(BuildContext context) {
    showModalBottomSheet(
        context: context,
        barrierColor: AppColors.black.withOpacity(0.35),
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) {
          String selectedCounty = BlocProvider.of<AllNewsBloc>(context).state.selectedCountry;
          return BlocProvider.value(
            value: BlocProvider.of<AllNewsBloc>(context),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  decoration: const BoxDecoration(
                    borderRadius : BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x80000000),
                          offset: Offset(0, -8),
                          blurRadius: 24,
                          spreadRadius: 0),
                    ],
                    color: Color(0xffffffff),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: SizedBox(
                      width: ScreenUtil().screenWidth,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.verticalSpace,
                          Center(
                            child: Container(
                                width: 72,
                                height: 5,
                                decoration: const BoxDecoration(
                                  borderRadius : BorderRadius.all(Radius.circular(100)),
                                  color : Color.fromRGBO(196, 196, 196, 1),
                                )
                            ),
                          ),
                          20.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Filter',
                                style: TextStyle(
                                    color: Color.fromRGBO(3, 29, 47, 1),
                                    fontFamily: 'Nunito',
                                    fontSize: 22,
                                    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                    fontStyle: FontStyle.normal
                                ),
                              ),
                              Bounce(
                                borderRadius: 16,
                                onTap: () {
                                  setState(() {
                                    selectedCounty = BlocProvider.of<AllNewsBloc>(context).state.selectedCountry;
                                  });
                                },
                                child: SvgPicture.asset('assets/images/reset_button.svg',
                                  semanticsLabel: 'reset_button',
                                ),
                              ),
                            ],
                          ),
                          25.verticalSpace,
                          const Text(
                            'Filter by Country',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(3, 29, 47, 1),
                                fontFamily: 'Nunito',
                                fontSize: 14,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                                height: 1,
                                fontStyle: FontStyle.normal
                            ),
                          ),
                          10.verticalSpace,
                          Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              CategoryChip(
                                name: 'All',
                                isSelected: selectedCounty == 'all',
                                onTap: () {
                                  setState(() {
                                    selectedCounty = 'all';
                                  });
                                },
                              ),
                              ...countryList
                                  .map((e) => CategoryChip(
                                        name: e.name,
                                        isSelected: selectedCounty == e.code,
                                        onTap: () {
                                          setState(() {
                                            selectedCounty = e.code;
                                          });
                                        },
                                      ))
                                  .toList()
                            ],
                          ),
                          32.verticalSpace,
                          MainButton(
                            text: 'Apply',
                            onTap: () {
                              context.read<AllNewsBloc>().add(FilterApplied(countryName: selectedCounty));
                              Navigator.pop(context);
                            },
                          ),
                          48.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
