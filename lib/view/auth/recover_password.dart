import 'package:flutter/material.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/utilities/buttons.dart';
import 'package:smart_pay/utilities/textfield.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

  handleSend(BuildContext context) {
    Nav.gotoRecoveryCode(context);
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
              // Vertical Spacing
              const SizedBox(height: 16),

              // Top Illustration
              Image.asset(
                "assets/images/lockIcon.png",
                width: 90,
              ),

              // Vertical Spacing
              const SizedBox(height: 16),

              // Header Text
              const Text(
                "Passsword Recovery",
                style: TextStyle(
                    color: primary, fontSize: 24, fontWeight: FontWeight.w600),
              ),

              // Vertical Spacing
              const SizedBox(height: 12),

              const Text(
                "Enter your registered email below to receive password instructions",
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),

              // Vertical Spacing
              const SizedBox(height: 32),

              // Email Field
              const MyTextField(
                placeholder: "Email",
              ),

              // Vertical Spacing
              const Spacer(),

              // Send Mail Button
              MyButton(onTap: () => handleSend(context), label: "Send me email")
            ],
          ),
        ),
      ),
    );
  }
}
