// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/utilities/buttons.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  String name = "";

  handlePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("fullName") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    handlePrefs();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Thumbs Up Image
              Image.asset(
                "assets/images/welcome.png",
                width: 140,
              ),

              // Vertical Spacing
              const SizedBox(height: 32),

              // Header Text
              Text(
                "Congratulations, $name",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: primary, fontSize: 24, fontWeight: FontWeight.w700),
              ),

              // Body Text
              const Text(
                "You've completed the onboarding,\n you can start using",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),

              // Vertical Spacing
              const SizedBox(height: 32),

              // Get Started Button
              MyButton(onTap: () => Nav.gotoHome(context), label: "Get Started")
            ],
          ),
        ),
      ),
    );
  }
}
