import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final bool enabled;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final Widget? icon;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.fullWidth = true,
    this.enabled = true,
    this.backgroundColor = Colors.white,
    this.foregroundColor = const Color.fromARGB(255, 22, 107, 182),
    this.borderRadius = 12.0,
    this.icon,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w500,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    final buttonText = Text(
      label,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );

    final buttonChild =
        icon == null
            ? buttonText
            : Row(
              mainAxisSize: MainAxisSize.min,
              children: [icon!, const SizedBox(width: 8), buttonText],
            );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            color:
                backgroundColor == Colors.white
                    ? Colors.grey.shade300
                    : Colors.transparent,
          ),
          elevation: 0, // Flat design
        ),
        child: buttonChild,
      ),
    );
  }
}
