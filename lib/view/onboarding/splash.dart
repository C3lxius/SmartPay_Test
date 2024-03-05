import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_pay/view/auth/login.dart';
import 'package:smart_pay/view/auth/login_pin.dart';
import 'package:smart_pay/view/onboarding/slider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Check if it is first time running app or if logged in...
  // ... then navigate based on that
  handleNavigation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime =
        prefs.getBool("firstTime") ?? true; // if true, then first time
    String isLoggedIn = prefs.getString("pin") ??
        ""; // if pin is saved, Navigate to Pin Screen else email login

    // Navigate To Next Screen Two Seconds After Init
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (_) => isFirstTime
                  ? const SliderScreen()
                  : isLoggedIn.isNotEmpty
                      ? const LoginPinScreen()
                      : const LoginScreen()));
    });
  }

  @override
  void initState() {
    handleNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          // Centered Smart Pay Logo
          child: Image.asset(
            "assets/images/logo.png",
            width: 148,
            height: 130,
          ),
        ),
      ),
    );
  }
}
