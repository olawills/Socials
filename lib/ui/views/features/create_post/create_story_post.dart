import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/core/firebase/firestore_methods.dart';
import 'package:social/core/models/exports.dart';
import 'package:social/core/providers/user_provider.dart';
import 'package:social/ui/shared/exports.dart';
import 'package:social/ui/shared/utils/pick_image.dart';
import 'package:social/ui/shared/utils/snackbar_widget.dart';

class CreateStoryPost extends StatefulWidget {
  const CreateStoryPost({super.key});

  @override
  State<CreateStoryPost> createState() => _CreateStoryPostState();
}

class _CreateStoryPostState extends State<CreateStoryPost> {
  String _image = '';
  // FirebaseUploadImage imagePicker = FirebaseUploadImage();

  final uploadImage = FirebaseUploadImage();
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
              _image != ''
                  ? Consumer<FirestoreMethods>(builder: (context, story, _) {
                      return InkWell(
                        onTap: () async {
                          String res = await story
                              .uploadStories(DateTime.now(), _image, user)
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
                          child: story.isLoading == true
                              ? SizedBox(
                                  height: 10,
                                  width: 10,
                                  // padding: const EdgeInsets.all(6),
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.socialBlue),
                                )
                              : CustomText(
                                  message: 'Post to Story',
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
      body: Center(
        child: TextButton(
          onPressed: () {
            uploadImage.uploadPicture().then((value) {
              setState(() {
                _image = value;
              });
            });
          },
          child: _image == ''
              ? SvgPicture.asset('assets/icons/Share.svg',
                  // ignore: deprecated_member_use
                  color: Colors.white,
                  height: 70)
              : Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain, image: FileImage(File(_image))),
                  ),
                ),
        ),
      ),
    );
  }
}
