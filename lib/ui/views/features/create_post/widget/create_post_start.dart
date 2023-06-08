import 'package:flutter/material.dart';
import 'package:social/ui/shared/exports.dart';
import 'package:social/ui/shared/utils/pick_image.dart';

class CreatePostStart extends StatefulWidget {
  const CreatePostStart({super.key});

  @override
  State<CreatePostStart> createState() => _CreatePostStartState();
}

class _CreatePostStartState extends State<CreatePostStart>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final uploadImage = FirebaseUploadImage();
  bool expand = false;

  List<String> iconsUrl = [
    'assets/icons/Image.svg',
    'assets/icons/GIF.svg',
    'assets/icons/Camera.svg',
    'assets/icons/Attachment.svg'
  ];
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            NavigationData.pushToCreatePostView(context);
          },
          child: CustomText(
            message: 'CREATE POST',
            style: titleTextSemiBold.copyWith(
              color: AppColors.lightWhite,
            ),
          ),
        ),
      ),
    );
  }
}
