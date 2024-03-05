// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/functions/Others/snackbar.dart';
import 'package:smart_pay/functions/Remote%20Service/remote.dart';
import 'package:smart_pay/utilities/buttons.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.token});
  final Map<String, String> token;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpFieldController controller = OtpFieldController();
  var hiddenMail = ""; // Hidden email to show in text
  bool enabled = false; // Diables Button until certain conditions are met
  bool isLoading = false; // When Loading
  String otp = ""; // OTP variable to be set later

  late Timer _timer;
  int countDown = 30;

  void handleTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (countDown == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            countDown--;
          });
        }
      },
    );
  }

  handleHiddenEmail() {
    var email = widget.token['email']; // get email string
    var index = email!.indexOf('@'); // Get index of @ char.

    hiddenMail = email.substring(index);
  }

  handleSnack(String content) {
    return showSnack(
        content: content,
        context: context,
        color: Colors.red,
        icon: Icons.error_outline_outlined);
  }

  handleConfirm(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    var email = widget.token['email']!;

    // Check if Otp field is empty and show error message
    if (otp.isEmpty) {
      handleSnack("Please Fill the OTP Fields");
    }

    try {
      var response = await Remote().verifyToken(email, otp);

      // If response is not 200 (An error)
      if (response['code'] != 200) {
        handleSnack(response['message']);
      }

      Nav.gotoBio(context, email);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    handleTimer();
    handleHiddenEmail();
    Timer(const Duration(seconds: 1), () {
      showModal(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel;
    super.dispose();
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
                "Verify it's you",
                style: TextStyle(
                    color: primary, fontSize: 28, fontWeight: FontWeight.w600),
              ),

              // Vertical Spacing
              const SizedBox(height: 12),

              // MultiColored  Text
              RichText(
                text: TextSpan(
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: textColor),
                    children: [
                      const TextSpan(text: 'We sent a code to ('),
                      TextSpan(
                        text: ' *****$hiddenMail ',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: primary),
                      ),
                      const TextSpan(
                          text: '). Enter it here to verify your identity'),
                    ]),
              ),

              // Vertical Spacing
              const SizedBox(height: 32),

              // OTP Boxes
              OTPTextField(
                controller: controller,
                length: 5,
                width: MediaQuery.of(context).size.width,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w700, color: primary),
                fieldWidth: 56,
                fieldStyle: FieldStyle.box,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                otpFieldStyle: OtpFieldStyle(
                  focusBorderColor: secondary,
                  enabledBorderColor: Colors.transparent,
                  backgroundColor: fillgray,
                ),
                onCompleted: (pin) {
                  setState(() {
                    enabled = true;
                    otp = pin;
                  });
                },
              ),

              // Vertical Spacing
              const SizedBox(height: 32),

              // Resend Code Text
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Resend Code $countDown secs",
                  style: const TextStyle(
                      color: deepGray,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),

              // Vertical Spacing
              const Spacer(),

              // Confirm Button
              MyButton(
                  onTap: () => handleConfirm(context),
                  enabled: enabled,
                  isLoading: isLoading,
                  label: "Confirm"),
            ],
          ),
        ),
      ),
    );
  }

  showModal(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
          child: SizedBox(
            // height: 220,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OTP code',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: primary),
                    ),
                  ],
                ),

                const Divider(
                  color: indicatorGray,
                  thickness: 1,
                ),

                // Spacing
                const SizedBox(height: 8.0),

                // Text
                const Text(
                  'Allow SmartPay to enter the code?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: textColor),
                ),

                // Spacing
                const SizedBox(height: 8.0),

                // Text
                Text(
                  'Your SmartPay OTP is: ${widget.token['token']}. This number is only valid for 5 minutes',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: plainGray),
                ),

                // Spacing
                const SizedBox(height: 24.0),

                // Allow Button
                MyButton(
                    label: 'Allow',
                    onTap: () {
                      setState(() {
                        controller.set(widget.token['token']!.split(''));
                        Navigator.pop(context);
                      });
                    }),

                // SPacing
                const SizedBox(height: 40)
              ],
            ),
          ),
        );
      },
    );
  }
}
