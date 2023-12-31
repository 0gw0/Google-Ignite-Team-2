import 'package:flutter/material.dart';
import 'package:healthy_fish_app/components/categories/category_item.dart';
import 'package:healthy_fish_app/data/categories.dart';

class CategoriesFishComponent extends StatefulWidget {
  const CategoriesFishComponent({
    super.key,
  });

  @override
  State<CategoriesFishComponent> createState() =>
      _CategoriesFishComponentState();
}

class _CategoriesFishComponentState extends State<CategoriesFishComponent> {
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
            categoriesDetailScreen.length,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = index;
                    });
                  },
                  child: Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(left: 22, right: 30)
                        : index == categories.length - 1
                            ? const EdgeInsets.only(right: 22)
                            : const EdgeInsets.only(right: 30),
                    child: CategoryItem(
                      category: categoriesDetailScreen[index],
                      selected: selectedCategory == index,
                    ),
                  ),
                )),
      ),
    );
  }
}
