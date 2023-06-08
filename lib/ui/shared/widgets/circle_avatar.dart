import 'package:flutter/material.dart';
import 'package:social/ui/shared/exports.dart';

class CircleAvatarWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final double? size;
  const CircleAvatarWidget({
    super.key,
    required this.onTap,
    required this.image,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return OnTapHandler(
      onTap: onTap,
      child: CircleAvatar(
        radius: size ?? 18,
        backgroundColor: lightGrey,
        child: CircleAvatar(
          radius: 15,
          child: SvgPicture.asset(
            image,
            height: 20,
            // ignore: deprecated_member_use
            color: kWhiteColor,
          ),
        ),
      ),
    );
  }
}
