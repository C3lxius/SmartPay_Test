import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/functions/Navigation/nav_methods.dart';
import 'package:smart_pay/utilities/buttons.dart';
import 'package:smart_pay/utilities/indicator.dart';
import 'package:smart_pay/utilities/slider_body.dart';

// Content for Intro Sliders
const sliderContent = [
  {
    "image": "assets/images/device.png",
    "overlay": "assets/images/illustration.png",
    "header": "Finance app the safest and most trusted",
    "caption":
        "Your finance work starts here. Our here to help you track and deal with speeding up your transactions."
  },
  {
    "image": "assets/images/device_2.png",
    "overlay": "assets/images/illustration_2.png",
    "header": "The fastest transaction process only here",
    "caption":
        "Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient."
  }
];

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  final PageController _pageController = PageController(keepPage: false);

  int limit = 0; // For Indicator.

  // Set limit to current page view index every time it changes
  onPageChanged(int page) {
    setState(() {
      limit = page;
    });
  }

  // Handle Navigation between pages
  handlePageChange() {
    _pageController.page != 1
        ? _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn)
        : Nav.gotoLogin(context);
  }

  // Save First time variable to false so this page...
  // only shows first time the app is opened on a device
  handleFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("firstTime", false); // SKips slider page if not first time
  }

  @override
  void initState() {
    handleFirstTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Top Right Aligned Clickable Skip Text
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Nav.gotoLogin(context),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontSize:
                              18, // Figma text sizes generally look 2-4 units smaller in flutter apps (So i had to adjust in order to get the same look)
                          fontWeight: FontWeight.w600,
                          color: tealColor),
                    ),
                  ),
                ),
              ),

              // Sliding Page View Body
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: onPageChanged,
                  children: sliderContent
                      .map((singleContent) => SliderBody(
                            content: singleContent,
                          ))
                      .toList(),
                ),
              ),

              // Slider Indicator
              Padding(
                padding: const EdgeInsets.only(bottom: 34.0, top: 16.0),
                child: Indicator(limit: limit),
              ),

              // Bottom Aligned Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: MyButton(
                  label: "Get Started",
                  onTap: handlePageChange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
