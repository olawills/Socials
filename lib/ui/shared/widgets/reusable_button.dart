import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/radius.dart';

class ReusableButton extends StatelessWidget {
  final bool isResponsive;
  final double? height;
  final double? width;
  final Color? color;
  final bool isLoading;
  final String? label;
  final TextStyle? labelStyle;
  final Function() onTap;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  const ReusableButton(
      {super.key,
      this.isResponsive = false,
      this.height,
      this.isLoading = false,
      this.width,
      this.color,
      this.labelStyle,
      required this.onTap,
      this.borderColor,
      this.borderRadius,
      this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: isResponsive || isLoading == true ? height : 50,
        width: isResponsive || isLoading == true ? width : double.infinity,
        decoration: ShapeDecoration(
          color:
              isResponsive || isLoading == true ? color : AppColors.socialBlue,
          shape: RoundedRectangleBorder(
              borderRadius: isResponsive == true
                  ? borderRadius ?? mediumBorderRadius
                  : mediumBorderRadius,
              side: BorderSide(
                color: isResponsive == true
                    ? borderColor ?? Colors.white
                    : AppColors.socialBlue,
              )),
        ),
        child:
            // isResponsive == true
            //     ? Row(
            //         children: const [],
            //       )
            Center(
          child: Text(
            label ?? '',
            style: labelStyle,
          ),
        ),
      ),
    );
  }
}
