import 'package:flutter/material.dart';
import 'package:social/ui/shared/exports.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              message: 'Alerts',
              style: titleTextBold,
            ),
            OnTapHandler(
              onTap: () {},
              child: CustomText(
                message: 'Mark all as read',
                style: bodyTextMedium.copyWith(color: AppColors.socialPink),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                message: 'TODAY',
                style: titleTextBold.copyWith(color: lightGrey),
              ),
              verticalSpaceMicroSmall,
              SizedBox(
                height: 200,
                child: ListView.separated(
                  itemCount: 2,
                  separatorBuilder: (_, index) {
                    return Divider(color: lightGrey, thickness: 0.9);
                  },
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: grey,
                        radius: 20,
                        child: CircleAvatar(
                          backgroundColor: AppColors.darkBlack.withOpacity(0.1),
                          radius: 18,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/icons/Like.svg',
                              // ignore: deprecated_member_use
                              color: AppColors.socialBlue,
                            ),
                          ),
                        ),
                      ),
                      title: CustomText(
                        message: 'Sofia, John and +19 others liked your post.',
                        style: secondaryTextMedium,
                      ),
                      subtitle: CustomText(
                        message: '10m ago',
                        style: secondaryTextMedium.copyWith(color: lightGrey),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
