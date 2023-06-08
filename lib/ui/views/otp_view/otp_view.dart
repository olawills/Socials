import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/core/models/user_model.dart';
import 'package:social/core/providers/user_provider.dart';
import 'package:social/ui/shared/utils/snackbar_widget.dart';

import '../../shared/exports.dart';

class OptView extends StatefulWidget {
  const OptView({super.key});

  @override
  State<OptView> createState() => _OptViewState();
}

class _OptViewState extends State<OptView> {
  bool isVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();

    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isVerified) {
      sendEmailVerification();

      timer = Timer.periodic(
          const Duration(seconds: 30), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    FirebaseAuth.instance.currentUser!;

    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isVerified) {
      timer?.cancel();
    }
  }

  Future sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 30));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      showAlert(context: context, message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).getUser;
    return isVerified
        ? NavigationData.moveToUploadView(context)
        : Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        message: 'Almost there...',
                        style: titleTextBold.copyWith(fontSize: 28),
                      ),
                      CustomText(
                        message: 'We sent an email to ${user.email}',
                        style: titleTextMedium.copyWith(fontSize: 28),
                      ),
                      verticalSpaceMicroSmall,
                      // Center(
                      //   child: ReusableButton(
                      //     isLoading: isVerified,
                      //     onTap: canResendEmail ? sendEmailVerification : null,
                      //     color: isVerified == true
                      //         ? lightGrey
                      //         : AppColors.socialBlue,
                      //     label: 'Resend code',
                      //   ),
                      // ),
                    ],
                  )),
            )),
          );
  }
}
