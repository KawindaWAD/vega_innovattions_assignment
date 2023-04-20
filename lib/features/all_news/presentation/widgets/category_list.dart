import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/const/const.dart';
import '../../../common/presentation/widgets/category_chip.dart';
import '../../../dashboard/presentation/bloc/top_news/top_news_bloc.dart';
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
                      // context.read<TopNewsBloc>().add(TopNewsRequested(category: categoryStringList.elementAt(index)));
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
}