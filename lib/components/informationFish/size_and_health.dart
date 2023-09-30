
import 'package:flutter/material.dart';
import 'package:healthy_fish_app/utils/constants/colors.dart';
import 'package:healthy_fish_app/utils/constants/spaces.dart';
import 'package:healthy_fish_app/components/shared/txt_style.dart';
import 'package:healthy_fish_app/models/fish.dart';

// This file contains Size and Health data classes for each fish. We could add another column for happiness etc if needed


class SizeAndHealth extends StatelessWidget {
  const SizeAndHealth({
    super.key,
    required this.fish,
  });

  final FishsModel fish;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Size',
                style: subHeaderStyle.copyWith(
                    color: blue, fontSize: 18),
              ),
              pVSpace24,
              Text(
                '${fish.size} m',
                style: pBodyeStyle.copyWith(
                    color: white, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Column(
            children: [
              Text(
                'Health',
                style: subHeaderStyle.copyWith(
                    color: blue, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text(
                '${fish.health} seashells',
                style: pBodyeStyle.copyWith(
                    color: white, fontWeight: FontWeight.bold),
              )
            ],
          )
        ]);
  }
}
