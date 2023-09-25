import 'package:flutter/widgets.dart';
import 'package:space_app/components/shared/txt_style.dart';
import 'package:space_app/utils/constants/colors.dart';

class DailyChallenge extends StatelessWidget {
  const DailyChallenge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Daily Challenges',
              style: headerStyle.copyWith(fontSize: 20, color: white)),
          Text('see all',
              style: headerStyle.copyWith(
                  fontSize: 20, color: white.withOpacity(0.5))),
        ],
      ),
    );
  }
}
