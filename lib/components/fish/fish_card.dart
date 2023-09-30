import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthy_fish_app/components/fish/fish_item.dart';
import 'package:healthy_fish_app/main.dart';
import 'package:healthy_fish_app/screens/detail_screen.dart';
import 'package:healthy_fish_app/utils/extension/nav.dart';

import 'package:healthy_fish_app/utils/extension/screen_size.dart';

class FishCard extends StatefulWidget {
  const FishCard({
    super.key,
  });

  @override
  State<FishCard> createState() => _FishCardState();
}

class _FishCardState extends State<FishCard> {
  PageController? pageController;
  double? pageOffset = 1;
  double viewPortFraction = 0.85;

  @override
  void initState() {
    super.initState();
    pageController =
        PageController(initialPage: 1, viewportFraction: viewPortFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController!.page;
            });
          });
  }

  @override
  void dispose() {
    super.dispose();
    pageController!.dispose();
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHeight * 0.5,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: listFish.length,
        controller: pageController,
        itemBuilder: (context, index) {
          double scale = max(viewPortFraction,
              (1 - (pageOffset! - index).abs() + viewPortFraction));
          return GestureDetector(
            onTap: () {
              context.pushNav(
                  screen: DetailScreen(
                fish: listFish[index],
              ));
            },
            child: FishItem(
              viewPortFraction: viewPortFraction,
              scale: scale,
              fish: listFish[index],
            ),
          );
        },
      ),
    );
  }
}
