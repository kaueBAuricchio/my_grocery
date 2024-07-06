import 'package:flutter/material.dart';
import 'package:my_grocery/src/config/custom_colors.dart';

class AppNameWidget extends StatelessWidget {
  const AppNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        style: const TextStyle(
          fontSize: 30,
        ),
        children: [
          const TextSpan(
              text: 'Grocery',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
          TextSpan(
            text: 'store',
            style: TextStyle(
                color: CustomColors.customContrastColor,
                fontWeight: FontWeight.w600),
          ),
        ]));
  }
}
