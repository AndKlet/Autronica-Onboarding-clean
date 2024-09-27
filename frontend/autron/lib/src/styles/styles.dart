import 'package:flutter/material.dart';

// Function to create a hover effect for a container
MouseRegion createHoverEffect({
  required Widget child,
  required Color defaultColor,
  required Color hoverColor,
  List<BoxShadow>? hoverShadow,
}) {
  bool isHovered = false;

  return MouseRegion(
    onEnter: (_) => isHovered = true,
    onExit: (_) => isHovered = false,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isHovered ? hoverColor : defaultColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isHovered ? hoverShadow : null,
      ),
      child: child,
    ),
  );
}
