import 'package:api_provider_016/config/components/utils.dart';
import 'package:api_provider_016/config/extension.dart';
import 'package:flutter/material.dart';

class DisplayBox extends StatelessWidget {
  const DisplayBox({
    super.key,
    required this.boxTitle,
    required this.boxIcon,
    required this.onPressed,
    this.heightFactor = 0.2,
    this.widthFactor = 0.3,
  });

  final String boxTitle;
  final Widget boxIcon;
  final double heightFactor;
  final double widthFactor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Using the extension to calculate dimensions based on screen size
    double boxHeight = context.mediaQueryHeight * heightFactor;
    double boxWidth = context.mediaQueryWidth * widthFactor;

    return InkWell(
      onTap: () {
        onPressed();
        Utils.toastMessage(
          "Man you are currerntly entering an $boxTitle",
        );
      },
      child: SizedBox(
        height: boxHeight,
        width: boxWidth,
        child: Column(
          children: [
            // Icon box with flexible size
            SizedBox(
              height:
                  boxWidth, // Making the height same as the width for a square icon area
              width: boxWidth,
              child: FittedBox(
                fit: BoxFit.contain,
                child: boxIcon,
              ),
            ),
            // Adding a gap between the icon and the title
            8.height,
            // Title text
            Flexible(
              child: Text(
                boxTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // Prevent text overflow
              ),
            ),
          ],
        ),
      ),
    );
  }
}
