import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/core/firebase/firebase_storage.dart';
import 'package:social/ui/shared/utils/pick_image.dart';
import 'package:social/ui/shared/utils/snackbar_widget.dart';

import '../../shared/exports.dart';

class ImageUploadView extends StatefulWidget {
  const ImageUploadView({super.key});

  @override
  State<ImageUploadView> createState() => _ImageUploadViewState();
}

class _ImageUploadViewState extends State<ImageUploadView> {
  // final auth = FirebaseAuthentication();
  final uploadImage = FirebaseUploadImage();
  String _image = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _image != ''
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(
                            File(_image),
                          ),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt1ceyneFkZchgkrwN7dZxWNl_C5Dctvc5BzNh_rEzPQ&s',
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    left: 90,
                    child: OnTapHandler(
                      onTap: () {
                        uploadImage.uploadPicture().then((value) {
                          setState(() {
                            _image = value;
                          });
                        });
                      },
                      child: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              verticalSpaceMicro,
              CustomText(
                message: 'Click on the icon to upload your image',
                style: titleTextBold,
              ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableButton(
                    isResponsive: true,
                    height: 60,
                    width: 120,
                    onTap: () {
                      NavigationData.moveToFeatures(context);
                    },
                    color: AppColors.socialBlue,
                    label: 'Skip',
                    labelStyle: secondaryTextMedium,
                    borderRadius: normalBorderRadius,
                    borderColor: kWhiteColor,
                  ),
                  Consumer<FirebaseStorageManager>(
                      builder: (context, upload, child) {
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   if (upload.message != '') {
                    //     showAlert(context: context, message: upload.message);
                    //     upload.resetMessage();
                    //   }
                    // });
                    return ReusableButton(
                      isResponsive: upload.status,
                      isLoading: true,
                      height: 60,
                      width: 120,
                      onTap: () {
                        final userId = FirebaseAuth.instance.currentUser!.uid;
                        if (_image != '') {
                          upload.uploadPicturesToStorage(
                            userId,
                            File(_image),
                          );
                          NavigationData.moveToFeatures(context);
                        } else {
                          showAlert(
                            context: context,
                            message: 'Upload image',
                            style: secondaryTextMedium,
                          );
                        }
                      },
                      borderColor: AppColors.socialBlue,
                      color: upload.status == true ? lightGrey : kWhiteColor,
                      label:
                          upload.status == true ? 'Please wait...' : 'Continue',
                      labelStyle:
                          secondaryTextMedium.copyWith(color: kDarkColor),
                      borderRadius: normalBorderRadius,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
