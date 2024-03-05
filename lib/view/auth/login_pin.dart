import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/functions/Others/snackbar.dart';
import 'package:smart_pay/utilities/buttons.dart';

class LoginPinScreen extends StatefulWidget {
  const LoginPinScreen({super.key});

  @override
  State<LoginPinScreen> createState() => _LoginPinScreenState();
}

class _LoginPinScreenState extends State<LoginPinScreen> {
  bool enabled = false;
  bool isLoading = false;
  String name = "";
  String pinCode = ""; // Pin to be recieved from user
  String sfPin = ""; // Pin to be retrieved from local storage

  handlePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sfPin = prefs.getString("pin") ?? "";
    setState(() {
      name = prefs.getString("fullName") ?? "";
    });
  }

  handleLogin() {
    // Check Entered Pin against SharedPreference Pin
    if (pinCode == sfPin) {
      showSnack(content: "Login Successful", context: context);
      Nav.gotoHome(context);
    } else {
      showSnack(
          content: "Incorrect Pin : $sfPin",
          context: context,
          color: Colors.red,
          icon: Icons.error_outline_outlined);
    }
  }

  @override
  void initState() {
    handlePrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BackButton
              const MyBackButton(),

              // Vertical Spacing
              const SizedBox(height: 24),

              // Welcome Text
              Text(
                "Hi, $name 👋",
                style: const TextStyle(
                  color: primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Vertical Spacing
              const SizedBox(height: 8),

              const Text(
                "Sign in below with your Pin",
                style: TextStyle(
                  color: primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),

              // Vertical Spacing
              const SizedBox(height: 32),

              OTPTextField(
                length: 5,
                width: MediaQuery.of(context).size.width,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600, color: primary),
                otpFieldStyle: OtpFieldStyle(
                  borderColor: secondary,
                  focusBorderColor: secondary,
                  enabledBorderColor: secondary,
                  backgroundColor: Colors.transparent,
                ),
                onCompleted: (value) => setState(() {
                  enabled = true;
                  pinCode = value;
                }),
              ),

              // Vertical Spacing
              const Spacer(),

              // Login Button
              MyButton(onTap: handleLogin, enabled: enabled, label: "Sign In"),

              // Vertical Spacing
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
