// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/utilities/buttons.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final OtpFieldController controller = OtpFieldController();
  bool enabled = false;
  String pinCode = "";

  handlePin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("pin", pinCode);
    Nav.gotoWelcome(context);
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
              const SizedBox(height: 32),

              // Top Level Text
              const Text(
                "Set your PIN code",
                style: TextStyle(
                    color: primary, fontSize: 24, fontWeight: FontWeight.w600),
              ),

              // Vertical Spacing
              const SizedBox(height: 12),

              const Text(
                "We use state-of-the-art security measures to protect your information at all times",
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),

              // Vertical Spacing
              const SizedBox(height: 32),

              // Pin Field
              OTPTextField(
                length: 5,
                width: MediaQuery.of(context).size.width,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w900, color: primary),
                obscureText: true,
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

              // Create Pin Button
              MyButton(onTap: () => handlePin(), label: "Create Pin")
            ],
          ),
        ),
      ),
    );
  }
}
