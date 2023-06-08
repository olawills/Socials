import 'package:flutter/material.dart';
import 'package:social/ui/shared/constants/colors.dart';
import 'package:social/ui/shared/constants/custom_text.dart';
import 'package:social/ui/shared/constants/text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  // final bool isObscureText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool autoFocus;
  final String? labelText;
  final bool issuffixIcon;
  final bool isValidationMessage;
  final String? validationMessage;
  final BorderRadius? radius;
  final bool hasRoundedRadius;
  final Color? fllColor;
  final bool changeFilledColor;
  final BorderSide? borderSide;
  final Widget? suffixIcon;
  // final bool hasLabelText;
  const CustomTextField({
    super.key,
    this.hintText,
    // this.isObscureText = false,
    required this.controller,
    required this.textInputType,
    this.validator,
    this.labelText,
    this.autoFocus = false,
    this.issuffixIcon = false,
    this.isValidationMessage = false,
    this.validationMessage,
    this.radius,
    this.hasRoundedRadius = false,
    this.fllColor,
    this.changeFilledColor = false,
    this.borderSide,
    this.suffixIcon,
    // this.hasLabelText = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisibility = false;
  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: widget.hasRoundedRadius == true
          ? widget.radius!
          : BorderRadius.circular(10),
      borderSide: widget.borderSide ?? Divider.createBorderSide(context),
    );
    final enabledBorder = OutlineInputBorder(
      borderRadius: widget.hasRoundedRadius == true
          ? widget.radius!
          : BorderRadius.circular(10),
      borderSide: widget.borderSide ??
          BorderSide(
            color: kDarkColor,
          ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(message: widget.labelText ?? '', style: secondaryTextMedium),
        TextFormField(
          textAlign: TextAlign.start,
          controller: widget.controller,
          obscureText:
              widget.issuffixIcon == true ? !passwordVisibility : false,
          keyboardType: widget.textInputType,
          validator: widget.validator,
          autofocus: widget.autoFocus,
          expands: false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            suffix: widget.issuffixIcon == true
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisibility = !passwordVisibility;
                      });
                    },
                    icon: Icon(
                        passwordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: grey),
                  )
                : null,
            hintText: widget.hintText,
            border: inputBorder,
            enabledBorder: enabledBorder,
            focusedBorder: inputBorder,
            filled: true,
            fillColor:
                widget.changeFilledColor == true ? widget.fllColor : lightGrey,
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
        CustomText(
            message: widget.isValidationMessage == true
                ? widget.validationMessage ?? ''
                : '',
            style: secondaryTextMedium)
      ],
    );
  }
}
