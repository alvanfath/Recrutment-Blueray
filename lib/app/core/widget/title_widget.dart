import 'package:flutter/widgets.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: title,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 8),
        TextWidget(
          text: subtitle,
          fontSize: 14,
          color: Constants.get.textSecondary,
        ),
      ],
    );
  }
}
