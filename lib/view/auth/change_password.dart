import 'package:flutter/material.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/utilities/buttons.dart';
import 'package:smart_pay/utilities/textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isObscured = true;

  handleChange(BuildContext context) {
    Nav.gotoLogin(context);
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
                "Create New Password",
                style: TextStyle(
                    color: primary, fontSize: 24, fontWeight: FontWeight.w600),
              ),

              // Vertical Spacing
              const SizedBox(height: 12),

              const Text(
                "Please, enter a new password below different from the previous password",
                style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),

              // Vertical Spacing
              const SizedBox(height: 32),

              // Password Field
              MyTextField(
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
              ),

              // Vertical Spacing
              const SizedBox(height: 16),

              // Password Field
              MyTextField(
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
              ),

              // Vertical Spacing
              const Spacer(),

              // Create Pin Button
              MyButton(
                  onTap: () => handleChange(context),
                  label: "Create New Password")
            ],
          ),
        ),
      ),
    );
  }
}
