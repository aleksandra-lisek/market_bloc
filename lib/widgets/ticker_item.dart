import 'package:flutter/material.dart';
import 'package:market_bloc/utils/hex_color.dart';

import 'package:market_bloc/widgets/focus_aware_container.dart';
import 'package:market_bloc/widgets/interaction_state_listener.dart';
import 'package:market_bloc/widgets/touch_feedback.dart';

class TickerItem extends StatefulWidget {
  final String tickerName;
  const TickerItem({
    super.key,
    required this.tickerName,
  });

  @override
  State<TickerItem> createState() => _TickerItemState();
}

class _TickerItemState extends State<TickerItem> {
  late Set<MaterialState> _states = {};

  bool get _isFocused => _states.contains(MaterialState.focused);
  void _onStatesChanged(Set<MaterialState> value) {
    setState(() {
      _states = value;
    });
  }

  MaterialStateProperty<Color> backgroundColor(Set<MaterialState> states) {
    return MaterialStateProperty.resolveWith<Color>(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return HexColor('D9D9D9');
        } else if (states.contains(MaterialState.pressed)) {
          return const Color.fromARGB(76, 217, 217, 217);
        } else if (states.contains(MaterialState.hovered)) {
          return const Color.fromARGB(76, 217, 217, 217);
        } else if (states.isEmpty) {
          return const Color.fromARGB(36, 217, 217, 217);
        }
        return const Color.fromARGB(36, 217, 217, 217);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InteractionStateListener(
      focusNode: FocusNode(),
      onStatesChanged: _onStatesChanged,
      isDisabled: false,
      child: FocusAwareContainer(
        isFocused: _isFocused,
        focusBorderColor: const Color.fromARGB(255, 153, 85, 247),
        borderRadius: BorderRadius.circular(8.0),
        child: TouchFeedback(
          backgroundColor: backgroundColor(_states),
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {},
          states: _states,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
            child: Text(
              widget.tickerName,
              style: TextStyle(
                fontSize: 16,
                color: HexColor('575151'),
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
