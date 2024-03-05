// SnackBar
import 'package:flutter/material.dart';
import 'package:smart_pay/constants/colors.dart';

// SnackBar Method to be used ~Mostly~ for Error Handling
showSnack({
  required String content,
  required BuildContext context,
  IconData? icon,
  Color? color,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 2),
      content: Card(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Container(
                  width: 10.0,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color ?? primary,
                    borderRadius:
                        const BorderRadius.horizontal(left: Radius.circular(7)),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Icon(
                  icon ?? Icons.check_circle,
                  color: color ?? primary,
                  size: 20,
                ),
                const SizedBox(
                  width: 12.0,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.6,
                  child: Text(
                    content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: textColor, fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                    onTap: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        size: 16,
                      ),
                    ))
              ],
            ),
          )),
    ),
  );
}
