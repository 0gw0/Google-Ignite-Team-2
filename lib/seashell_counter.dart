import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seashell_provider.dart';

class SeashellCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SeashellProvider>(
      builder: (context, seashellProvider, child) {
        return Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                ImageIcon(
                  AssetImage('../assets/images/seashell.png'),
                  color: Colors.yellow, // Change this to your desired color
                ),
                const SizedBox(width: 4),
                Text(
                  '${seashellProvider.seashellCount}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




