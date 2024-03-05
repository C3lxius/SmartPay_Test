import 'package:flutter/material.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/utilities/buttons.dart';

class RecoveryCodeScreen extends StatefulWidget {
  const RecoveryCodeScreen({super.key});

  @override
  State<RecoveryCodeScreen> createState() => _RecoveryCodeScreenState();
}

class _RecoveryCodeScreenState extends State<RecoveryCodeScreen> {
  final email = TextEditingController();
  bool editComplete = false;

  handleContinue(BuildContext context) {
    Nav.gotoChangePassword(context);
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
                "assets/images/personIcon.png",
                width: 90,
              ),

              // Vertical Spacing
              const SizedBox(height: 16),

              // Header Text
              const Text(
                "Verify your identity",
                style: TextStyle(
                    color: primary, fontSize: 24, fontWeight: FontWeight.w600),
              ),

              // Vertical Spacing
              const SizedBox(height: 12),

              // MultiColored  Text
              RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: textColor),
                    children: [
                      TextSpan(text: 'Where would you like'),
                      TextSpan(
                        text: ' Smartpay ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: secondary),
                      ),
                      TextSpan(text: 'to send your code?'),
                    ]),
              ),

              // Vertical Spacing
              const SizedBox(height: 32),

              // Email Field
              TextFormField(
                controller: email,
                style: const TextStyle(
                    color: primary, fontSize: 16, fontWeight: FontWeight.w600),
                cursorColor: primary,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  labelText: "Email",
                  labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: lightGray),
                  prefixIcon: editComplete
                      ? const Icon(
                          Icons.check_circle,
                          color: secondary,
                        )
                      : null,
                  suffixIcon: const Icon(
                    Icons.email_outlined,
                    color: lightGray,
                  ),
                  errorStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
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
                onEditingComplete: () => setState(() {
                  editComplete = true;
                }),
              ),

              // Vertical Spacing
              const Spacer(),

              // Send Mail Button
              MyButton(onTap: () => handleContinue(context), label: "Continue")
            ],
          ),
        ),
      ),
    );
  }
}
