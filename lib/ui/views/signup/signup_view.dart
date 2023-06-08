import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/core/firebase/authentication.dart';
import 'package:social/ui/shared/utils/snackbar_widget.dart';
import 'package:social/ui/shared/utils/validation_manager.dart';

import '../../shared/exports.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with RestorationMixin {
  final RestorableTextEditingController _emailController =
      RestorableTextEditingController();
  final RestorableTextEditingController _firstNameController =
      RestorableTextEditingController();
  final RestorableTextEditingController _lastNameController =
      RestorableTextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(top: 20),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    message: 'Get Started on Socials',
                    style: titleTextBold.copyWith(
                      fontSize: size * 0.06,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                verticalSpaceMini,
                CustomTextField(
                  labelText: 'First Name',
                  controller: _firstNameController.value,
                  textInputType: TextInputType.name,
                  hintText: 'Enter First Name',
                  validator: (value) =>
                      ValidationManager.firstNameValidator(value: value),
                ),
                verticalSpaceMicroSmall,
                CustomTextField(
                  labelText: 'Last Name',
                  controller: _lastNameController.value,
                  textInputType: TextInputType.name,
                  hintText: 'Enter Last Name',
                  validator: (value) =>
                      ValidationManager.lastNameValidator(value: value),
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
                  issuffixIcon: true,
                  validator: (value) =>
                      ValidationManager.passwordValidator(value: value),
                ),
                verticalSpaceMini,
                Consumer<FirebaseAuthentication>(builder: (context, auth, _) {
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   if (auth.errorResponse != '') {
                  //     showAlert(context: context, message: auth.errorResponse);
                  //     auth.resetResponse();
                  //   }
                  // });
                  return ReusableButton(
                    isLoading: auth.isLoading,
                    onTap: () async {
                      final response = await auth.signUpUsers(
                        firstName: _firstNameController.value.text.trim(),
                        lastName: _lastNameController.value.text.trim(),
                        email: _emailController.value.text.trim(),
                        password: _passwordController.text.trim(),
                        context: context,
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
                    label: auth.isLoading == true ? 'Signin up...' : 'Sign up',
                  );
                }),
                verticalSpaceMicro,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      message: 'Already have an account',
                      style: secondaryTextMedium,
                    ),
                    horizontalSpaceSmall,
                    OnTapHandler(
                      onTap: () => NavigationData.pushTologin(context),
                      child: CustomText(
                        message: 'Sign in ',
                        style: secondaryTextBold.copyWith(
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
    );
  }

  @override
  String? get restorationId => 'signup';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_firstNameController, 'first_name');
    registerForRestoration(_lastNameController, 'last_name');
    registerForRestoration(_emailController, 'email');
  }
}
