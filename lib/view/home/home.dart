// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/functions/Others/snackbar.dart';
import 'package:smart_pay/functions/Remote%20Service/remote.dart';
import 'package:smart_pay/utilities/buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String name; //  User's full name
  late String token; // User's Auth Token
  late bool pinExists; // Check if Pin exists to provide option
  String phrase = ""; // Secret Phrase to be retrieved

  // Get secret phrase
  handlePhrase() async {
    // Get Needed Shared Preferences Variables
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("fullName") ?? "";
    token = prefs.getString("token") ?? "";
    pinExists = prefs.containsKey("pin");

    // Call API Endpoint
    var response = await Remote().getSecret(token);

    // If Success, set Phrase else use placeholder
    if (response.isNotEmpty) {
      phrase = response;
    } else {
      phrase = "An error must have occured while fetching your secret phrase";
    }
  }

  // Error SnackBar Method
  showErrorSnack(String content) {
    return showSnack(
        content: content,
        context: context,
        color: Colors.red,
        icon: Icons.error_outline_outlined);
  }

  //  Logout Method
  handleLogout() async {
    try {
      var response = await Remote().logout();

      if (response == false) {
        showErrorSnack("Failed to Logout due to error");
        return;
      }

      // On Logout, Remove all Stored Info except First Time Variable
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("fullName");
      prefs.remove("pin");

      // Navigate to Sign in Page
      Nav.gotoLogin(context);
    } finally {}
  }

  @override
  void initState() {
    handlePhrase();
    Timer(const Duration(seconds: 1), () {
      showBodyDialog(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }

  // Simple Dialog Ui for Home Page
  showBodyDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Image.asset(
                    'assets/images/home.png',
                    width: 98,
                  ),
                ],
              ),

              // Spacing
              const SizedBox(height: 24),

              // Text
              Text(
                'Welcome $name🎁',
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 24, color: primary),
              ),

              // Spacing
              const SizedBox(height: 24),

              // Text
              Text(
                phrase,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: textColor),
              ),

              // Spacing
              const SizedBox(height: 24),

              // Button
              !pinExists
                  ? MyButton(
                      onTap: () => Nav.gotoPin(context),
                      label: "Set Pin",
                    )
                  : const SizedBox.shrink(),

              // Spacing
              const SizedBox(height: 16),

              // Button
              MyButton(
                onTap: handleLogout,
                label: "Logout",
              )
            ],
          ),
        ),
      ),
    );
  }
}
