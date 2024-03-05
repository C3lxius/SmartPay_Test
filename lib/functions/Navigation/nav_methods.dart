import 'package:flutter/cupertino.dart';
import 'package:smart_pay/view/auth/change_password.dart';
import 'package:smart_pay/view/auth/recover_password.dart';
import 'package:smart_pay/view/auth/verify_identity.dart';
import 'package:smart_pay/view/auth/user_bio.dart';
import 'package:smart_pay/view/auth/enter_pin.dart';
import 'package:smart_pay/view/auth/login.dart';
import 'package:smart_pay/view/auth/verify_otp.dart';
import 'package:smart_pay/view/auth/register.dart';
import 'package:smart_pay/view/auth/welcome.dart';
import 'package:smart_pay/view/home/home.dart';

// Navigation Class and Methods for cleaner more modular code

class Nav {
  // Navigate to Login Page
  static gotoLogin(BuildContext context) {
    return Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (_) => const LoginScreen()));
  }

  // Navigate to Password Recovery Page
  static gotoPasswordRecovery(BuildContext context) {
    return Navigator.push(context,
        CupertinoPageRoute(builder: (_) => const PasswordRecoveryScreen()));
  }

  // Navigate to Password Recovery - Enter Reset Code Page
  static gotoRecoveryCode(BuildContext context) {
    return Navigator.push(context,
        CupertinoPageRoute(builder: (_) => const RecoveryCodeScreen()));
  }

  // Navigate to Change Password Page
  static gotoChangePassword(BuildContext context) {
    return Navigator.push(context,
        CupertinoPageRoute(builder: (_) => const ChangePasswordScreen()));
  }

  // Navigate to Sign Up Page
  static gotoRegister(BuildContext context) {
    return Navigator.push(
        context, CupertinoPageRoute(builder: (_) => const RegisterScreen()));
  }

  // Navigate to Verify OTP Page
  static gotoOtp(BuildContext context, Map<String, String> token) {
    return Navigator.push(
        context, CupertinoPageRoute(builder: (_) => OtpScreen(token: token)));
  }

  // Navigate to User Bio Page
  static gotoBio(BuildContext context, String email) {
    return Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (_) => BioScreen(email: email)));
  }

  // Navigate to Set Login Pin Page
  static gotoPin(BuildContext context) {
    return Navigator.push(
        context, CupertinoPageRoute(builder: (_) => const PinScreen()));
  }

  // Navigate to Welcome Page
  static gotoWelcome(BuildContext context) {
    return Navigator.push(
        context, CupertinoPageRoute(builder: (_) => WelcomeScreen()));
  }

  // Navigate to Home Page
  static gotoHome(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (_) => const HomeScreen()),
        (Route<dynamic> route) => false);
  }
}
