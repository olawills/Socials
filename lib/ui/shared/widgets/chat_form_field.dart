import 'package:flutter/material.dart';

import '../exports.dart';

class ChatFormField extends StatelessWidget {
  final TextEditingController messageController;
  final bool isIcon;
  final Widget? iconWidget;
  const ChatFormField({
    super.key,
    required this.messageController,
    this.isIcon = false,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        hasRoundedRadius: true,
        changeFilledColor: true,
        fllColor: grey,
        radius: largeBorderRadius,
        controller: messageController,
        textInputType: TextInputType.text,
        hintText: 'Type your reply here...',
        borderSide: BorderSide.none,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(6.0),
          child: isIcon == true
              ? iconWidget
              : CircleAvatar(
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
      ),
    );
  }
}
