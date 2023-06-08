import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/core/providers/firebase_message_provider.dart';
import 'package:social/ui/shared/exports.dart';
import 'package:social/ui/shared/widgets/circle_avatar.dart';

import '../features/home/widgets/exports.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool expand = true;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  String images =
      'https://images.pexels.com/photos/2625122/pexels-photo-2625122.jpeg?cs=srgb&dl=pexels-ali-pazani-2625122.jpg&fm=jpg';
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<FirebaseMessage>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatarWidget(
              size: 16,
              onTap: () => NavigationData.pushBack(context),
              image: 'assets/icons/Arrow Left.svg',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  ProfileAvatar(
                    onTap: () {},
                    isMessageAvatar: true,
                    isChatSize: true,
                    displayPhoto: images,
                  ),
                  verticalSpaceMicroSmall,
                  CustomText(
                    message: 'Jessica Thompson',
                    style: bodyTextMedium,
                  ),
                ],
              ),
            ),
            CircleAvatarWidget(
              size: 16,
              onTap: () {},
              image: 'assets/icons/Dots Vertical.svg',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              // // verticalMicroMiniSmall,
              Divider(color: grey, thickness: 1.5),
              // verticalMicroMiniSmall,
              // CustomText(message: 'SEP 14, 2021', style: secondaryTextMedium),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: kDarkColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: ChatFormField(
                    isIcon: true,
                    messageController: chatProvider.chatController,
                    iconWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedSize(
                          duration: const Duration(seconds: 3),
                          reverseDuration: const Duration(seconds: 3),
                          child: Container(),
                        ),
                        InkWell(
                          onTap: () {
                            expand
                                ? controller.forward()
                                : controller.reverse();
                            setState(() {
                              expand = !expand;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 3),
                            height: 30,
                            width: 30,
                            child: SvgPicture.asset(
                              'assets/icons/Plus.svg',
                              // ignore: deprecated_member_use
                              color: lightGrey,
                            ),
                          ),
                        ),
                        horizontalSpaceSmall,
                        InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.gradientColor2,
                            child: SvgPicture.asset(
                              'assets/icons/Send.svg',
                              height: 20,
                              // ignore: deprecated_member_use
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
