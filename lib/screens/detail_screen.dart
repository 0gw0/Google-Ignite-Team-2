import 'package:flutter/material.dart';
import 'package:healthy_fish_app/components/categories/categories_fish_component.dart';
import 'package:healthy_fish_app/components/icons_component.dart';
import 'package:healthy_fish_app/components/informationFish/size_and_health.dart';
import 'package:healthy_fish_app/components/shared/txt_style.dart';

import 'package:healthy_fish_app/models/fish.dart';
import 'package:healthy_fish_app/utils/constants/colors.dart';
import 'package:healthy_fish_app/utils/constants/spaces.dart';
import 'package:healthy_fish_app/utils/extension/screen_size.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.fish}) : super(key: key);
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
