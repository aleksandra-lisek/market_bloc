import 'package:flutter/material.dart';
import 'package:market_bloc/utils/platform_info.dart';

class TouchFeedback extends StatelessWidget {
  final MaterialStateProperty<Color> backgroundColor;
  final Set<MaterialState> states;
  final BorderRadius borderRadius;

  final void Function()? onTap;
  final Widget child;

  const TouchFeedback({
    super.key,
    required this.backgroundColor,
    required this.borderRadius,
    this.onTap,
    required this.child,
    required this.states,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor.resolve(states),
      borderRadius: borderRadius,
      child: Builder(
        builder: (context) {
          if (isAndroidPlatform) {
            return InkWell(
              highlightColor: backgroundColor.resolve({MaterialState.pressed}),
              hoverColor: backgroundColor.resolve({MaterialState.hovered}),
              borderRadius: borderRadius,
              onTap: onTap,
              child: child,
            );
          }
          return GestureDetector(
            onTap: onTap,
            child: Material(
              color: Colors.transparent,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
