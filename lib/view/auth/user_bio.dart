// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/functions/Others/snackbar.dart';
import 'package:smart_pay/functions/Remote%20Service/remote.dart';
import 'package:smart_pay/utilities/buttons.dart';
import 'package:smart_pay/utilities/textfield.dart';

const modalContent = [
  {
    "flag": "US.png",
    "code": "US",
    "name": "United States",
  },
  {
    "flag": "GB.png",
    "code": "GB",
    "name": "United Kingdom",
  },
  {
    "flag": "SG.png",
    "code": "SG",
    "name": "Singapore",
  },
  {
    "flag": "CN.png",
    "code": "CN",
    "name": "China",
  },
  {
    "flag": "NL.png",
    "code": "NL",
    "name": "Netherlands",
  },
  {
    "flag": "ID.png",
    "code": "ID",
    "name": "Indonesia",
  },
];

class BioScreen extends StatefulWidget {
  const BioScreen({super.key, this.email = ""});
  final String email;

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  bool isObscured = true;
  bool isLoading = false;
  bool enabled = false;

  final fullName = TextEditingController();
  final userName = TextEditingController();
  final country = TextEditingController();
  final password = TextEditingController();

  handleSnack(String content) {
    return showSnack(
        content: content,
        context: context,
        color: Colors.red,
        icon: Icons.error_outline_outlined);
  }

  // Method to Validate form
  handleValidate(String? value) {
    if (fullName.text.isNotEmpty &&
        country.text.isNotEmpty &&
        password.text.isNotEmpty &&
        password.text.length > 5) {
      setState(() {
        enabled = true;
      });
    }
  }

  String passwordValidate(String? value) {
    String pattern = r'^(?=.*?[0-9]).{6,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value!)) {
      return 'Must have 6 characters and a Number';
    } else {
      return "";
    }
  }

  handleContinue(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    var userInfo = {
      "full_name": fullName.text.trim(),
      "username": userName.text.trim(),
      "email": widget.email,
      "country": country.text.trim(),
      "password": password.text.trim(),
      "device_name": "mobile"
    };

    try {
      var response = await Remote().register(userInfo);

      // If response is not 200 (An error)
      if (response['code'] != 200) {
        handleSnack(response['message']);
        return;
      }

      // The following only runs if Register is successful
      // Initialise Shared Preferences for storing local data
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Save a variable on device for user's name as for persistent login
      prefs.setString("fullName", response['user']['full_name']);

      // Navigate to Home Page
      Nav.gotoPin(context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    fullName.dispose();
    userName.dispose();
    country.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BackButton
              const MyBackButton(),

              // Vertical Spacing
              const SizedBox(height: 32),

              // MultiColored Top Level Text
              RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: primary),
                    children: [
                      TextSpan(text: 'Hey there! tell us a bit about '),
                      TextSpan(
                        text: 'yourself',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: secondary),
                      ),
                    ]),
              ),

              // Vertical Spacing
              const SizedBox(height: 32),

              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    // Full Name Field
                    MyTextField(
                      controller: fullName,
                      placeholder: "Full name",
                      onChange: handleValidate,
                    ),

                    // Vertical Spacing
                    const SizedBox(height: 16),

                    // UserName Field
                    MyTextField(
                      controller: userName,
                      placeholder: "Username",
                    ),

                    // Vertical Spacing
                    const SizedBox(height: 16),

                    // Country Field
                    MyTextField(
                      controller: country,
                      placeholder: "Select Country",
                      readOnly: true,
                      onTap: () => showModal(context),
                      postIcon: const Icon(Icons.keyboard_arrow_down,
                          color: textColor),
                      onChange: handleValidate,
                    ),

                    // Vertical Spacing
                    const SizedBox(height: 16),

                    // Password Field
                    MyTextField(
                      controller: password,
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
                      onChange: handleValidate,
                      validator: passwordValidate,
                    ),

                    // Vertical Spacing
                    const SizedBox(height: 32),

                    // Confirm Button
                    MyButton(
                        onTap: () => handleContinue(context),
                        isLoading: isLoading,
                        enabled: enabled,
                        label: "Continue"),
                  ],
                ),
              ),
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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 0),
          child: SizedBox(
            // height: 220,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SearchBar Row
                Row(
                  children: [
                    const Expanded(
                      child: MyTextField(
                        placeholder: "Search",
                      ),
                    ),

                    // Spacing
                    const SizedBox(width: 16),

                    // Cancel Button
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                // Spacing
                const SizedBox(height: 24),

                Expanded(
                  child: ListView(
                    children: modalContent
                        .map((content) => CountryCard(
                              image: content['flag']!,
                              code: content['code']!,
                              name: content['name']!,
                              controller: country,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CountryCard extends StatefulWidget {
  const CountryCard({
    super.key,
    required this.image,
    required this.code,
    required this.name,
    required this.controller,
  });
  final String image;
  final String code;
  final String name;
  final TextEditingController controller;

  @override
  State<CountryCard> createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.controller.text = widget.code;
          Navigator.pop(context);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            // Country Flag
            Image.asset(
              "assets/images/${widget.image}",
              width: 32,
            ),

            // Horizontal Spacing
            const SizedBox(width: 16),

            // Country Code
            Text(
              widget.code,
              style: const TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            // Horizontal Spacing
            const SizedBox(width: 16),

            // Country Name
            Text(
              widget.name,
              style: const TextStyle(
                color: primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Spacing
            const Spacer(),

            // Check Icon
            widget.controller.text == widget.code
                ? const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.check,
                      color: secondary,
                      size: 24,
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
