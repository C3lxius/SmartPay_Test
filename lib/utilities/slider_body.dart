import 'package:flutter/material.dart';
import 'package:smart_pay/constants/colors.dart';

class SliderBody extends StatelessWidget {
  const SliderBody({super.key, required this.content});
  final Map<String, String> content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Slider Body Image
              Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(content["image"]!),
                  )),
                  child: Image.asset(content["overlay"]!)),

              // Header Text With Gradient
              Container(
                padding: const EdgeInsets.only(top: 46),
                decoration: const BoxDecoration(
                    color: Colors.white,

                    // Adding a Linear Gradient At the top for fading effect
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.white30,
                          Colors.white,
                        ])),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header Text
                    Container(
                      padding: const EdgeInsets.only(top: 24),
                      margin: const EdgeInsets.only(bottom: 16),
                      color: Colors.white,
                      child: Text(
                        content["header"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: primary,
                        ),
                      ),
                    ),

                    // Caption Text
                    Text(
                      content["caption"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
