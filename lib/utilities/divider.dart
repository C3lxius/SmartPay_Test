import 'package:flutter/material.dart';
import 'package:smart_pay/constants/colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Divider Line
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Divider(
              color: indicatorGray,
            ),
          ),
        ),

        // Text
        Text(
          'OR',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: plainGray,
          ),
        ),

        // Divider Line
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Divider(
              color: indicatorGray,
            ),
          ),
        ),
      ],
    );
  }
}
