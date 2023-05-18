import 'package:flutter/material.dart';

import 'pallete.dart';

class FuatureBox extends StatelessWidget {
  const FuatureBox(
      {super.key,
      required this.color,
      required this.headerText,
      required this.discriptionText});
  final Color color;
  final String headerText;
  final String discriptionText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: const TextStyle(
                    fontFamily: "Cera Pro",
                    fontSize: 18,
                    color: Pallete.blackColor),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                discriptionText,
                style: const TextStyle(
                  fontFamily: "Cera Pro",
                  color: Pallete.blackColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
