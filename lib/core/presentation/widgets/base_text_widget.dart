import 'package:flutter/material.dart';

class BasicTextWidget extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final bool? softWrap;
  final TextDecoration textDecoration;
  final String? fontFamily;
  final double? height;
  const BasicTextWidget(
      {super.key,
      required this.text,
      required this.fontWeight,
      required this.fontSize,
      required this.color,
      this.height,
      this.textAlign = TextAlign.start,
      this.maxLines ,
      this.textDecoration = TextDecoration.none,
      this.textOverflow ,
      this.fontFamily = '',
        this.softWrap
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      softWrap: softWrap,
      textScaler: const TextScaler.linear(1.0),
      style: TextStyle(
         height: height,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: textDecoration,
          decorationColor: color,
          fontFamily: fontFamily,
      ),
    );
  }
}
