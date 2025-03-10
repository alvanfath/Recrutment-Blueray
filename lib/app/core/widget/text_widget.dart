import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign align;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final String family;
  const TextWidget({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
    this.color = const Color(0xff2D3338),
    this.align = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.fontStyle,
    this.family = 'Poppins',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: color,
        fontFamily: family,
        decoration: TextDecoration.none,
      ),
      textAlign: align,
    );
  }
}