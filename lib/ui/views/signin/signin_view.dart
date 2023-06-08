import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/core/firebase/authentication.dart';
import 'package:social/ui/shared/utils/snackbar_widget.dart';
import 'package:social/ui/shared/utils/validation_manager.dart';

import '../../shared/exports.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with RestorationMixin {
  final RestorableTextEditingController _emailController =
      RestorableTextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(top: 25),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    child: Center(
                      child: CustomText(
                        message: 'Welcome Back',
                        style: titleTextBold.copyWith(
                          fontSize: size * 0.06,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceMicroSmall,
                  CustomTextField(
                    labelText: 'Email',
                    controller: _emailController.value,
                    textInputType: TextInputType.emailAddress,
                    hintText: 'Enter Email',
                    validator: (value) =>
                        ValidationManager.emailValidator(value: value),
                  ),
                  verticalSpaceMicroSmall,
                  CustomTextField(
                    labelText: 'Password',
                    controller: _passwordController,
                    textInputType: TextInputType.name,
                    hintText: 'Enter Password',
                    // isObscureText: true,
                    issuffixIcon: true,
                    validator: (value) =>
                        ValidationManager.passwordValidator(value: value),
                  ),
                  verticalSpaceMini,
                  Consumer<FirebaseAuthentication>(builder: (context, auth, _) {
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   if (auth.errorResponse != '') {
                    //     showAlert(
                    //         context: context, message: auth.errorResponse);
                    //     auth.resetResponse();
                    //   }
                    // });
                    return ReusableButton(
                      isLoading: auth.isLoading,
                      onTap: () async {
                        final response = await auth.loginUsers(
                          context: context,
                          email: _emailController.value.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        if (response != 'success') {
                          // ignore: use_build_context_synchronously
                          showAlert(context: context, message: response);
                        } else {
                          return;
                        }
                      },
                      height: 50,
                      color: auth.isLoading == true
                          ? lightGrey
                          : AppColors.socialBlue,
                      label:
                          auth.isLoading == true ? 'Logging in...' : 'Log in',
                    );
                  }),
                  verticalSpaceMini,
                  Center(
                    child: OnTapHandler(
                      onTap: () => NavigationData.pushToResetPassword(context),
                      child: CustomText(
                        message: 'Forgot Password',
                        style: secondaryTextMedium.copyWith(
                          color: AppColors.socialBlue,
                        ),
                      ),
                    ),
                  ),
                  verticalMicroSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        message: 'Don\'t have an account?',
                        style: secondaryTextMedium,
                      ),
                      horizontalSpaceSmall,
                      OnTapHandler(
                        onTap: () => NavigationData.pushToSignup(context),
                        child: CustomText(
                          message: 'Sign Up ',
                          style: secondaryTextMedium.copyWith(
                            color: AppColors.socialBlue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  String? get restorationId => 'signin';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_emailController, 'email');
  }
}
