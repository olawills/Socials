import 'package:flutter/material.dart';

import '../../../../shared/exports.dart';

class ProfileAvatar extends StatelessWidget {
  final String displayPhoto;
  final bool isMessageAvatar;
  final VoidCallback onTap;
  final bool isProfileView;
  final bool isChatSize;
  const ProfileAvatar({
    super.key,
    required this.displayPhoto,
    this.isMessageAvatar = false,
    required this.onTap,
    this.isProfileView = false,
    this.isChatSize = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          isMessageAvatar == true
              ? CircleAvatar(
                  radius: isChatSize == true ? 20 : 22,
                  backgroundColor: lightGrey,
                  backgroundImage: CachedNetworkImageProvider(displayPhoto),
                )
              : CircleAvatar(
                  radius: isProfileView == true ? 75 : 22,
                  backgroundColor: AppColors.gradientColor2,
                  child: CircleAvatar(
                    radius: isProfileView == true ? 70 : 20,
                    backgroundColor: lightGrey,
                    backgroundImage: CachedNetworkImageProvider(displayPhoto),
                  ),
                ),
        ],
      ),
    );
  }
}
