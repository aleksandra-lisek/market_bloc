import 'package:flutter/material.dart';

class FocusAwareContainer extends StatelessWidget {
  final bool isFocused;
  final Color focusBorderColor;
  final BorderRadius borderRadius;
  final Widget child;
  const FocusAwareContainer({
    super.key,
    required this.isFocused,
    required this.focusBorderColor,
    required this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isFocused
            ? Border.all(
                color: focusBorderColor,
                width: 2,
              )
            : const Border(),
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.all(2),
      child: child,
    );
  }
}
