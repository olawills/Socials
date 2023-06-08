import 'package:flutter/material.dart';
import 'package:social/ui/shared/exports.dart';

class EmailMessageAvatar extends StatelessWidget {
  const EmailMessageAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => NavigationData.pushToMessageView(context),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: lightGrey,
        child: CircleAvatar(
          radius: 17,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: Container(
                  height: 7,
                  width: 5,
                  decoration: BoxDecoration(
                    color: AppColors.gradientColor1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/Message.svg',
                height: 20,
                // ignore: deprecated_member_use
                color: kWhiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
