import 'package:flutter/material.dart';
import 'package:smart_pay/constants/colors.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key, required this.limit});
  final int limit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          2,
          (index) => AnimatedContainer(
                margin: const EdgeInsets.only(right: 4.0),
                curve: Curves.easeIn,
                width: index == limit ? 32 : 6,
                height: 6,
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                    color: index == limit ? primary : indicatorGray,
                    borderRadius: BorderRadius.circular(4)),
              )),
    );
  }
}
