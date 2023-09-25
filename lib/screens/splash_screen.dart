import 'package:flutter/material.dart';
import 'package:space_app/components/animation/moving_fish.dart';
import 'package:space_app/components/shared/txt_style.dart';
import 'package:space_app/data/fish_animation.dart';
import 'package:space_app/screens/home_screen.dart';
import 'package:space_app/utils/constants/colors.dart';
import 'package:space_app/utils/extension/nav.dart';
import 'package:space_app/utils/extension/screen_size.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SizedBox(
        width: context.getWidth,
        height: context.getHeight,
        child: Stack(
          children: [
            MovingFish(
              animatePosition: FishAnimation(
                topAfter: -150,
                topBefore: -150,
                leftAfter: -650,
                leftBefore: -800,
                bottomAfter: -150,
                bottomBefore: -150,
              ),
              delayInMs: 1000,
              durationInMs: 2500,
              child: GestureDetector(
                  onDoubleTap: () {
                    context.pushNav(screen: const HomeScreen());
                  },
                  child: Image.asset("assets/images/coverpagefish.jpg")),
            ),
            Positioned(
                left: 25,
                bottom: 20,
                right: 25,
                child: RichText(
                  text: TextSpan(
                    style: headerStyle.copyWith(fontSize: 35),
                    children: [
                      const TextSpan(text: 'upgrade your '),
                      TextSpan(
                          text: 'fish',
                          style: headerStyle.copyWith(color: blue)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
