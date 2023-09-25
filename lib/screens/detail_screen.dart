import 'package:flutter/material.dart';
import 'package:space_app/components/categories/categories_fish_component.dart';
import 'package:space_app/components/icons_component.dart';
import 'package:space_app/components/informationFish/size_and_health.dart';
import 'package:space_app/components/shared/txt_style.dart';

import 'package:space_app/models/fish.dart';
import 'package:space_app/utils/constants/colors.dart';
import 'package:space_app/utils/constants/spaces.dart';
import 'package:space_app/utils/extension/screen_size.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.fish});
  final FishsModel fish;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Stack(
          children: [
            pVSpace24,
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: IconsComponent(),
                ),
                pVSpace24,
                const CategoriesFishComponent(),
                pVSpace64,
                Image.asset(
                  'assets/images/${fish.thumbnail}',
                  width: context.getWidth * 0.8,
                ),
                pVSpace24,
                Text(
                  fish.name!,
                  style: headerStyle.copyWith(fontSize: 32, color: white),
                ),
                pVSpace24,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: SizeAndHealth(fish: fish),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
