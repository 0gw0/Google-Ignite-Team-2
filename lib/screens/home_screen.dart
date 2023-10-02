import 'package:flutter/material.dart';
import 'package:healthy_fish_app/components/categories/categories_component.dart';
import 'package:healthy_fish_app/components/news/dailychallenge.dart';
import 'package:healthy_fish_app/components/news/news_item.dart';
import 'package:healthy_fish_app/components/fish/fish_card.dart';
import 'package:healthy_fish_app/components/shared/txt_style.dart';

import 'package:healthy_fish_app/utils/constants/colors.dart';
import 'package:healthy_fish_app/utils/constants/spaces.dart';

import '/seashell_counter.dart';  // Import the SeashellCounter
import '/components/icons_component.dart';   // Import the IconsComponent

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Text("Welcome!",
                      style: headerStyle.copyWith(color: white, fontSize: 32)),
                ),
                pVSpace16,
                const CategoriesComponent(),
                pVSpace24,
                const FishCard(),
                const DailyChallenge(),
                pVSpace16,
                const NewsItem()
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconsComponent(),  // Display the custom icons component
            ),
            Positioned(
              top: 20,
              right: 20,
              child: SeashellCounter(),  // Display the seashell counter at the bottom-right corner
            ),
          ],
        ),
      ),
    );
  }
}
