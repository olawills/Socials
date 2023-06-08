import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/core/firebase/firestore_methods.dart';
import 'package:social/core/models/exports.dart';
import 'package:social/core/providers/user_provider.dart';
import 'package:social/ui/shared/constants/constants.dart';
import 'package:social/ui/shared/exports.dart';
import 'package:social/ui/shared/utils/pick_image.dart';
import 'package:social/ui/shared/utils/snackbar_widget.dart';
import 'package:social/ui/views/features/home/widgets/exports.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  String? _image;
  FirebaseUploadImage imagePicker = FirebaseUploadImage();
  TextEditingController postController = TextEditingController();
  final uploadImage = FirebaseUploadImage();

  bool expand = true;
  bool isClicked = false;
  @override
  void initState() {
    super.initState();
    // _pageController
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    postController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => NavigationData.pushBack(context),
                child: CustomText(
                  message: 'Discard',
                  style: bodyTextMedium.copyWith(color: AppColors.socialBlue),
                ),
              ),
              _image != null
                  ? Consumer<FirestoreMethods>(builder: (context, post, _) {
                      return InkWell(
                        onTap: () async {
                          String res = await post
                              .uploadPosts(
                            postController.text.trim(),
                            File(_image!),
                            user.userUid,
                            "${user.firstName} ${user.lastName}",
                            user.displayPhoto ?? postUrl,
                          )
                              .whenComplete(() {
                            // ignore: use_build_context_synchronously
                            NavigationData.pushBack(context);
                          });
                          if (res == "sucesss") {
                            // ignore: use_build_context_synchronously
                            showAlert(context: context, message: 'Posted!...');
                          } else {
                            // ignore: use_build_context_synchronously
                            showAlert(context: context, message: res);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.gradientColor1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: post.isLoading == true
                              ? SizedBox(
                                  height: 10,
                                  width: 10,
                                  // padding: const EdgeInsets.all(6),
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.socialBlue),
                                )
                              : CustomText(
                                  message: 'Publish',
                                  style: bodyTextMedium.copyWith(
                                      color: AppColors.lightWhite),
                                ),
                        ),
                      );
                    })
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ProfileAvatar(
                      onTap: () => NavigationData.pushToProfileView(context),
                      isMessageAvatar: true,
                      displayPhoto: user.displayPhoto ?? postUrl,
                    ),
                    horizontalSpaceSmall,
                    Expanded(
                      child: TextFormField(
                        controller: postController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "What's on your mind?",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpaceMini,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        expand ? controller.forward() : controller.reverse();
                        setState(() {
                          expand = !expand;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: lightGrey),
                          borderRadius: miniMediumBorderRadius,
                        ),
                        child: SvgPicture.asset(
                          expand
                              ? 'assets/icons/Close.svg'
                              : 'assets/icons/Plus.svg',
                          // ignore: deprecated_member_use
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                    horizontalSpaceSmall,
                    AnimatedSize(
                      duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500),
                      child: Container(
                        height: 30,
                        width: expand ? null : 0,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: grey,
                          border: Border.all(color: lightGrey),
                          borderRadius: miniMediumBorderRadius,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              iconsUrl.length,
                              (index) {
                                final imageList = iconsUrl[index];
                                return GestureDetector(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        uploadImage
                                            .uploadPicture()
                                            .then((value) {
                                          setState(() {
                                            _image = value;
                                          });
                                        });
                                        break;
                                      case 1:
                                        // Action for the second icon
                                        break;
                                      case 2:
                                        // final image = imagePicker
                                        //     .pickImage(ImageSource.camera);
                                        // setState(() {
                                        //   _image = image;
                                        // });
                                        break;
                                      case 3:
                                        break;
                                      default:
                                        // final image = imagePicker
                                        //     .pickImage(ImageSource.gallery);
                                        // setState(() {
                                        //   _image = image;
                                        // });
                                        break;
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    imageList,
                                    // ignore: deprecated_member_use
                                    color: kWhiteColor,
                                  ),
                                );
                              },
                            )),
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                _image != null
                    ? Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: FileImage(File(_image!))),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
