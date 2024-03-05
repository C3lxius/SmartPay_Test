// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/functions/Others/snackbar.dart';
import 'package:smart_pay/functions/Remote%20Service/remote.dart';
import 'package:smart_pay/utilities/buttons.dart';
import 'package:smart_pay/utilities/divider.dart';
import 'package:smart_pay/utilities/textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool enabled = false;
  bool isLoading = false;

  final controller = TextEditingController();
  handleSnack(String content) {
    return showSnack(
        content: content,
        context: context,
        color: Colors.red,
        icon: Icons.error_outline_outlined);
  }

  signUp(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var email = controller.text
        .toLowerCase()
        .trim(); // remove spaces from email string and change to lower case

    // Check if email field is empty and show error message
    if (email.isEmpty) {
      handleSnack("Please Enter Valid Email");
    }

    try {
      var response = await Remote().verifyEmail(email);

      // If response is not 200 (An error)
      if (response['code'] != 200) {
        handleSnack(response['message']);
      }
      Map<String, String> otpDetails = {
        "email": email,
        "token": response['token']
      };

      Nav.gotoOtp(context, otpDetails);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BackButton
                const MyBackButton(),

                // Vertical Spacing
                const SizedBox(height: 32),

                // MultiColored Top Level Text
                RichText(
                  text: const TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: primary),
                      children: [
                        TextSpan(text: 'Create a '),
                        TextSpan(
                          text: 'Smartpay\n',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: secondary),
                        ),
                        TextSpan(text: 'account'),
                      ]),
                ),

                // Vertical Spacing
                const SizedBox(height: 24),

                // Register Form
                MyTextField(
                    controller: controller,
                    placeholder: "Email",
                    onChange: (value) => {
                          if (value.contains('@') && value.length > 3)
                            {
                              setState(() {
                                enabled = true;
                              }),
                            }
                        }),

                // Vertical Spacing
                const SizedBox(height: 24),

                // Login Button
                MyButton(
                    onTap: () => signUp(context),
                    isLoading: isLoading,
                    enabled: enabled,
                    label: "Sign Up"),

                // Vertical Spacing
                const SizedBox(height: 32),

                // Divider Row
                const MyDivider(),

                // Vertical Spacing
                const SizedBox(height: 24),

                // Socials Auth Section
                const Row(
                  children: [
                    // Google Login
                    SocialButton(image: "assets/images/google_logo.png"),

                    // Horixontal Spacing
                    SizedBox(width: 16),

                    // Icloud Login
                    SocialButton(image: "assets/images/apple_logo.png"),
                  ],
                ),

                // Vertical Spacing
                const Spacer(flex: 1),

                // Bottom text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    // Clickable Sign In text
                    GestureDetector(
                      onTap: () => Nav.gotoLogin(context),
                      child: const Text(
                        " Sign In",
                        style: TextStyle(
                          color: secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // Bottom Spacing
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
