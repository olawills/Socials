import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social/ui/shared/constants/colors.dart';
import 'package:social/ui/shared/constants/custom_text.dart';
import 'package:social/ui/shared/constants/spacing.dart';
import 'package:social/ui/shared/constants/text_styles.dart';
import 'package:social/ui/shared/utils/ontap_handler.dart';
import 'package:social/ui/shared/widgets/custom_text_field.dart';
import 'package:social/ui/shared/widgets/reusable_button.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: 100,
                //   child: Column(
                //     children: [
                //       CustomText(
                //         message: 'Reset Password',
                //         style: titleTextBold.copyWith(
                //           fontSize: size * 0.08,
                //           fontStyle: FontStyle.italic,
                //         ),
                //       ),
                //       CustomText(
                //         message:
                //             'We have sent a password reset link to your email',
                //         style: titleTextBold.copyWith(
                //           fontSize: size * 0.08,
                //         ),
                //       ),
                //       CustomText(
                //         message: 'Kindly click on the link to reset password,',
                //         style: titleTextBold.copyWith(
                //           fontSize: size * 0.08,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     CustomText(
                //       message:'Don\'t have an account?',
                //       style: secondaryTextBold,
                //     ),
                //     TextButton(
                //         onPressed: () {},
                //         child: Text(
                //           'Sign up',
                //           style: secondaryTextBold,
                //         ))
                //   ],
                // ),
                CustomText(
                  message: 'Reset Password',
                  style: titleTextBold.copyWith(fontSize: 28),
                ),
                verticalSpaceMicro,
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter email',
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                verticalSpaceMicro,
                ReusableButton(
                  isResponsive: false,
                  label: 'Check Email',
                  onTap: () {},

                  // color: model.hasValidation || model.emailIsEmpty
                  //     ? Colors.grey
                  //     : AppColors.kPrimaryColor,
                ),
                verticalSpaceMicro,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: secondaryTextBold,
                    ),
                    horizontalSpaceSmall,
                    OnTapHandler(
                      onTap: () => context.go('/signup'),
                      child: CustomText(
                        message: 'Sign up',
                        style: secondaryTextBold.copyWith(
                          color: AppColors.socialBlue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
