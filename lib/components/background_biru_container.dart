// background_biru_container.dart
import 'package:flutter/material.dart';

class BackgroundHeaderContainer extends StatelessWidget {
  final double height;
  final Color? color;

  const BackgroundHeaderContainer({super.key, this.height = 253, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.blue.shade700,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
    );
  }
}
