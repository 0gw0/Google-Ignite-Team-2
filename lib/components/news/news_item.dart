import 'package:flutter/material.dart';
import 'package:space_app/components/shared/txt_style.dart';
import 'package:space_app/data/dailychallenge.dart';
import 'package:space_app/utils/constants/colors.dart';
import 'package:space_app/utils/constants/spaces.dart';
import 'package:space_app/screens/goals.dart';

// class NewsItem extends StatelessWidget {
//   const NewsItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 22),
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//       decoration: BoxDecoration(
//         color: darkBlue,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Good Health, Cool Fishes!',
//                 style: pBodyeStyle.copyWith(fontSize: 16, height: 1.5),
//                 selectionColor: const Color.fromARGB(225, 225, 7, 178),
//               ),
//               const Icon(
//                 Icons.arrow_forward_ios_rounded,
//                 color: blue,
//               )
//             ],
//           ),
//           pVSpace16,
//           Text(
//             dailychallenge,
//             maxLines: 4,
//             overflow: TextOverflow.clip,
//             style: pBodyeStyle.copyWith(
//                 fontSize: 11, color: white, height: 1.5, letterSpacing: 1),
//           )
//         ],
//       ),
//     );
//   }
// }


class NewsItem extends StatelessWidget {
  const NewsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the ToDoList page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ToDoList(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: darkBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Good Health, Cool Fishes!',
                  style: pBodyeStyle.copyWith(fontSize: 16, height: 1.5),
                  selectionColor: const Color.fromARGB(225, 225, 7, 178),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: blue,
                )
              ],
            ),
            pVSpace16,
            Text(
              dailychallenge,
              maxLines: 4,
              overflow: TextOverflow.clip,
              style: pBodyeStyle.copyWith(
                  fontSize: 11, color: white, height: 1.5, letterSpacing: 1),
            )
          ],
        ),
      ),
    );
  }
}
