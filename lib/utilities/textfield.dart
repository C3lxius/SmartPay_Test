import 'package:flutter/material.dart';
import 'package:smart_pay/constants/colors.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      this.controller,
      this.isObscured = false,
      this.readOnly = false,
      this.postIcon,
      this.placeholder,
      this.onTap,
      this.onChange,
      this.validator,
      this.onSaved});
  final TextEditingController? controller;
  final bool isObscured;
  final bool readOnly;
  final Widget? postIcon;
  final void Function()? onTap;
  final void Function(String)? onChange;
  final String Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscured,
      readOnly: readOnly,
      onTap: onTap,
      style: const TextStyle(
          color: primary, fontSize: 16, fontWeight: FontWeight.w600),
      cursorColor: primary,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintText: placeholder,
        hintStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w400, color: lightGray),
        suffixIcon: postIcon,
        errorStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.red),
        filled: true,
        fillColor: fillgray,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: secondary,
              width: 1.0,
            )),
      ),
      onChanged: onChange,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
