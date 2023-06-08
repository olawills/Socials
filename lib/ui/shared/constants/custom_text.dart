import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String message;
  final TextStyle style;
  final TextOverflow? overflow;
  const CustomText({
    super.key,
    required this.message,
    required this.style,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: style,
      overflow: overflow,
    );
  }
}
