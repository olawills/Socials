import 'package:flutter/material.dart';
import 'package:social/ui/shared/exports.dart';

class AnimatedTextContainer extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onTap;

  const AnimatedTextContainer({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: miniMediumBorderRadius,
        ),
        child: CustomText(
          message: text,
          style: bodyTextMedium,
        ),
      ),
    );
  }
}
