import 'package:flutter/material.dart';
import 'dart:math';
import '/seashell_counter.dart';
import '/seashell_provider.dart';
import '/components/icons_component.dart'; // Import the IconsComponent
import 'package:healthy_fish_app/components/categories/categories_component.dart';
import 'package:healthy_fish_app/components/news/dailychallenge.dart';
import 'package:healthy_fish_app/components/news/news_item.dart';
import 'package:healthy_fish_app/components/fish/fish_card.dart';
import 'package:healthy_fish_app/components/shared/txt_style.dart';
import 'package:healthy_fish_app/utils/constants/colors.dart';
import 'package:healthy_fish_app/utils/constants/spaces.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create instances of SeashellCounter and IconsComponent
  final SeashellCounter _seashellCounter = SeashellCounter();
  final IconsComponent _iconsComponent = IconsComponent();

  // Simulate completing a task
  void _completeTask() {
    int earnedSeashells = _generateRandomSeashells();
    // Use the reference to call the updateSeashells method
    _seashellCounter.updateSeashells(context, earnedSeashells);
  }

  // Helper method to generate a random number of seashells
  int _generateRandomSeashells() {
    return Random().nextInt(10) + 1; // Generates a random number between 1 and 10
  }

  @override
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
                const NewsItem(),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _iconsComponent, // Display the custom icons component
            ),
            Positioned(
              top: 20,
              right: 20,
              child: _seashellCounter, // Display the seashell counter at the top-right corner
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _completeTask,
        child: Icon(Icons.check),
      ),
    );
  }
}
