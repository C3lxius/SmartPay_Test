// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/functions/Others/snackbar.dart';
import 'package:smart_pay/functions/Remote%20Service/remote.dart';
import 'package:smart_pay/utilities/buttons.dart';
import 'package:smart_pay/utilities/divider.dart';
import 'package:smart_pay/utilities/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscured = true; // For password field
  bool enabled = false; // For Button
  bool isLoading = false; // For Button

  // TextField Controllers
  final email = TextEditingController();
  final password = TextEditingController();

  // Simple Error Notifier SnackBar
  handleErrorSnack(String content) {
    return showSnack(
        content: content,
        context: context,
        color: Colors.red,
        icon: Icons.error_outline_outlined);
  }

  //  RegEx Validation for Password
  String passwordValidate(String? value) {
    String pattern = r'^(?=.*?[0-9]).{6,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value!)) {
      return 'Must have 6 characters and a Number';
    } else {
      return "";
    }
  }

  // Method to Validate form and Enable button on validation
  handleValidate(String? value) {
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        password.text.length > 5) {
      setState(() {
        enabled = true;
      });
    }
  }

  // Login Method
  singIn(BuildContext context) async {
    setState(() {
      isLoading = true; // Start Loading
    });

    // Set userInfo to be passed to API Endpoint
    var userInfo = {
      "email": email.text.trim(),
      "password": password.text.trim(),
      "device_name": "mobile"
    };

    try {
      // call API Endpoint
      var response = await Remote().login(userInfo);

      // If response is not 200 (An error)
      if (response['code'] != 200) {
        handleErrorSnack(response['message']);
        return;
      }

      // The following only runs if Login is successful
      // Initialise Shared Preferences for storing local data
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Save a variable on device for user's name as for persistent login
      prefs.setString("fullName", response['user']['full_name']);

      // Navigate to Home Page
      Nav.gotoHome(context);
    } finally {
      setState(() {
        isLoading = false; // Stop Loading
      });
    }
  }

  // Dispose Controllers
  @override
  void dispose() {
    email.dispose();
    password.dispose();
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
            height: MediaQuery.of(context).size.height - 88,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BackButton
                const MyBackButton(),

                // Vertical Spacing
                const SizedBox(height: 24),

                // Welcome Text
                const Text(
                  "Hi There! 👋",
                  style: TextStyle(
                    color: primary,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // Vertical Spacing
                const SizedBox(height: 8),

                // Sub Welcome Text
                const Text(
                  "Welcome back, Sign in to your account",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                // Vertical Spacing
                const SizedBox(height: 32),

                // Login Form
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      // Email Field
                      MyTextField(
                        controller: email,
                        placeholder: "Email",
                        onChange: handleValidate,
                      ),

                      // Vertical Spacing
                      const SizedBox(height: 16),

                      // Password Field
                      MyTextField(
                        controller: password,
                        placeholder: "Password",
                        isObscured: isObscured,
                        postIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscured = isObscured ? false : true;
                              });
                            },
                            color: plainGray,
                            icon: Icon(
                              isObscured
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            )),
                        onChange: handleValidate,
                        validator: passwordValidate,
                      ),
                    ],
                  ),
                ),

                // Vertical Spacing
                const SizedBox(height: 24),

                // Forgot Password
                InkWell(
                  onTap: () => Nav.gotoPasswordRecovery(context),
                  child: const Text('Forgot Password?',
                      style: TextStyle(
                          color: secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),

                // Vertical Spacing
                const SizedBox(height: 24),

                // Login Button
                MyButton(
                    onTap: () => singIn(context),
                    enabled: enabled,
                    isLoading: isLoading,
                    label: "Sign In"),

                // Vertical Spacing
                const SizedBox(height: 24),

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
                const Spacer(),

                // Bottom text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an account?",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Nav.gotoRegister(context),
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                          color: secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // Bottom Padding
                const SizedBox(height: 12)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
