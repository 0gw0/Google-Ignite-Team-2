// icons_component.dart

import 'package:flutter/material.dart';
import 'package:healthy_fish_app/utils/constants/colors.dart';
import 'package:healthy_fish_app/utils/extension/nav.dart';

class IconsComponent extends StatelessWidget {
  const IconsComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assuming you have a variable for seashell count, replace 0 with the actual count
    int seashellCount = 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.popNav();
          },
          child: Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: darkBlue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: blue,
            ),
          ),
        ),
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: darkBlue.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/seashell.png',  // Correct path to your seashell icon
                color: Colors.yellow,
                height: 24,  // Adjust the size as needed
                width: 24,
              ),
              Positioned(
                top: -3,
                right: -3,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: blue,
                  ),
                  child: Text(
                    seashellCount.toString(),
                    style: TextStyle(color: darkBlue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
