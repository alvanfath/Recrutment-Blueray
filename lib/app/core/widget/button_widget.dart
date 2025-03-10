import 'package:flutter/material.dart';
import 'package:recrutment_blueray/app/core/core.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? width;
  final Color? color;
  final Color? titleColor;
  final double? fontSize;
  final Color? splashColor;
  final double? paddingY;
  final Color? borderColor;
  final FontWeight? fontWeight;
  final double? borderRadius;
  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.width,
    this.color,
    this.titleColor,
    this.fontSize,
    this.splashColor,
    this.paddingY,
    this.borderColor,
    this.fontWeight,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: paddingY ?? 13.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          color: color ?? Constants.get.primaryColor,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: titleColor ?? Colors.white,
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.w500,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign align;
  final double paddingY;
  final VoidCallback onTap;
  final Alignment position;
  final HitTestBehavior behavior;
  const ButtonText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.color = const Color(0xFF20C2F3),
    this.align = TextAlign.center,
    this.paddingY = 12.5,
    required this.onTap,
    this.position = Alignment.center,
    this.behavior = HitTestBehavior.opaque,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: paddingY),
      alignment: position,
      child: GestureDetector(
        onTap: onTap,
        behavior: behavior,
        child: TextWidget(
          text: text,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          align: align,
        ),
      ),
    );
  }
}
