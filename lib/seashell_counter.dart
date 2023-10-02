import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seashell_provider.dart';

class SeashellCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SeashellProvider>(
      builder: (context, seashellProvider, child) {
        // Always return an empty container to keep the counter invisible
        return Container();
      },
    );
  }

  //update seashells
  void updateSeashells(BuildContext context, int earnedSeashells) {
    Provider.of<SeashellProvider>(context, listen: false)
        .updateSeashells(earnedSeashells);
  }
}
