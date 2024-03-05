import 'package:flutter/material.dart';
import 'package:smart_pay/constants/colors.dart';

// Reusable Button Widget
class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.onTap,
      required this.label,
      this.enabled = true,
      this.isLoading = false});
  final void Function()? onTap;
  final String label;
  final bool enabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled && !isLoading
          ? onTap
          : null, // If button is disabled or loading, do nothing onClick
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: enabled
              ? primary
              : disabled, // Bg color depends on if button is enabled
        ),
        child: isLoading // If loading show circular Indicator
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : Text(
                label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
      ),
    );
  }
}

// Reusable Back Button Widget
class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context), // onClick, go to last known route
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: indicatorGray),
            borderRadius: BorderRadius.circular(12)),
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 20,
        ),
      ),
    );
  }
}

// Reusable Social Authentication Button Widget
class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              border: Border.all(color: indicatorGray),
              borderRadius: BorderRadius.circular(16)),
          child: Image.asset(
            image,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
