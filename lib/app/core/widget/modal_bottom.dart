import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class ModaLBottomWidget extends StatelessWidget {
  final double padding;
  final String icon;
  final String title;
  final String? subtitle;
  final List<Widget> additionalContent;
  final bool isCloseButton;
  final bool isDashed;
  const ModaLBottomWidget({
    super.key,
    this.padding = 24,
    this.isDashed = false,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.additionalContent,
    this.isCloseButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          topContent(context),
          const SizedBox(height: 16),
          TextWidget(
            text: title,
            align: TextAlign.center,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            TextWidget(
              text: subtitle!,
              align: TextAlign.center,
              fontSize: 14,
              color: Constants.get.textSecondary,
            ),
          ],
          getAction(context),
        ],
      ),
    );
  }

  Widget getAction(BuildContext context) {
    if (additionalContent.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Container(
        margin: const EdgeInsets.only(top: 24),
        child: Column(
          children: additionalContent.map((e) => e).toList(),
        ),
      );
    }
  }

  Widget topContent(BuildContext context) {
    if (isCloseButton) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 32),
          SvgPicture.asset(
            icon,
            width: 60,
            height: 60,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              size: 24,
              color: Constants.get.textSecondary,
            ),
          )
        ],
      );
    }
    return SvgPicture.asset(
      icon,
      width: 60,
      height: 60,
    );
  }
}
