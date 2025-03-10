import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class MenuList extends StatelessWidget {
  final String text;
  final HeroIcons icon;
  final VoidCallback onTap;
  final bool isDivider;
  final String? lastContent;

  const MenuList({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.isDivider = true,
    this.lastContent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color:
                  isDivider ? Constants.get.borderPrimary : Colors.transparent,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                HeroIcon(
                  icon,
                  size: 16,
                  color: Constants.get.textPrimary,
                ),
                const SizedBox(width: 16),
                TextWidget(
                  text: text,
                  fontSize: 13,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (lastContent != null) ...[
                  TextWidget(
                    text: lastContent!,
                    color: const Color(0xff9BA6AF),
                  ),
                  const SizedBox(width: 8),
                ],
                HeroIcon(
                  HeroIcons.chevronRight,
                  color: Constants.get.primaryColor,
                  size: 16,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
