import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/core/models/exports.dart';
import 'package:social/core/providers/user_provider.dart';
import 'package:social/ui/shared/constants/constants.dart';
import 'package:social/ui/shared/exports.dart';
import 'package:social/ui/shared/widgets/circle_avatar.dart';
import 'package:social/ui/views/features/home/widgets/profile_avatar.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final TextEditingController chatController = TextEditingController();

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.darkBlack,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatarWidget(
              size: 16,
              onTap: () => NavigationData.pushBack(context),
              image: 'assets/icons/Arrow Left.svg',
            ),
            Center(
              child: CustomText(
                message: 'MESSAGES',
                style: titleTextBold,
              ),
            ),
            CircleAvatarWidget(
              size: 16,
              onTap: () {},
              image: 'assets/icons/Settings.svg',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                hasRoundedRadius: true,
                changeFilledColor: true,
                fllColor: grey,
                radius: largeBorderRadius,
                controller: chatController,
                textInputType: TextInputType.text,
                hintText: 'Who do you want to chat with?',
                borderSide: BorderSide.none,
                suffixIcon: Icon(Icons.search, color: lightGrey),
              ),
              // verticalMicroMiniSmall,
              Divider(color: grey, thickness: 1.5),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CustomText(
                  message: 'PINNED',
                  style: secondaryTextBold.copyWith(color: lightGrey),
                ),
              ),
              Row(
                children: List.generate(images.length, (index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: ProfileAvatar(
                      onTap: () {},
                      isMessageAvatar: true,
                      displayPhoto: user.displayPhoto![index],
                    ),
                  );
                }),
              ),
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: dummyUsers.length,
                  separatorBuilder: (_, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    );
                  },
                  itemBuilder: (_, index) {
                    return CustomText(
                        message: dummyUsers[index], style: secondaryTextBold);
                  },
                ),
              ),
              Divider(color: grey, thickness: 1.5),
              InkWell(
                onTap: () => NavigationData.pushToChatView(context),
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (_, index) {
                      return Divider(color: grey, thickness: 1.5);
                    },
                    itemCount: images.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: ProfileAvatar(
                          onTap: () {},
                          isMessageAvatar: true,
                          displayPhoto: images[index],
                        ),
                        title: CustomText(
                          message: dummyUsers[index],
                          style: bodyTextBody,
                        ),
                        subtitle: CustomText(
                          message: 'Hey you! Are u there?',
                          style: secondaryTextBold,
                        ),
                        trailing: CustomText(
                          message: '4h ago',
                          style: secondaryTextBold.copyWith(color: lightGrey),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
