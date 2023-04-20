import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/const/const.dart';
import '../../../common/presentation/widgets/category_chip.dart';
import '../bloc/top_news/top_news_bloc.dart';

class CategoryChipList extends StatelessWidget {
  const CategoryChipList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: BlocSelector<TopNewsBloc, TopNewsState, String>(
        selector: (state) {
          return state.selectedCategory;
        },
        builder: (context, selectedCategory) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            scrollDirection: Axis.horizontal,
            itemCount: categoryStringList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: CategoryChip(
                  name: categoryStringList.elementAt(index),
                  isSelected: selectedCategory == categoryStringList.elementAt(index),
                  onTap: () {
                    context.read<TopNewsBloc>().add(TopNewsRequested(category: categoryStringList.elementAt(index)));
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




