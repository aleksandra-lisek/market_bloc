import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InteractionStateListener extends StatefulWidget {
  final Set<MaterialState> initialStates;
  final FocusNode? focusNode;
  final Widget child;
  final bool isDisabled;
  final ValueChanged<Set<MaterialState>> onStatesChanged;

  const InteractionStateListener({
    required this.child,
    required this.onStatesChanged,
    this.focusNode,
    this.isDisabled = false,
    this.initialStates = const {},
    super.key,
  });

  @override
  State<InteractionStateListener> createState() =>
      _InteractionStateListenerState();
}

class _InteractionStateListenerState extends State<InteractionStateListener> {
  late final MaterialStatesController _materialStatesController;
  late FocusNode _focusNode;

  bool get _isHovering =>
      _materialStatesController.value.contains(MaterialState.hovered);

  bool get _isDisabled =>
      _materialStatesController.value.contains(MaterialState.disabled);

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _materialStatesController = MaterialStatesController(widget.initialStates);
    _materialStatesController.addListener(_onMaterialStatesUpdatedNextFrame);
  }

  @override
  void didUpdateWidget(covariant InteractionStateListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDisabled != widget.isDisabled) {
      _materialStatesController.update(
          MaterialState.disabled, widget.isDisabled);
      _onMaterialStatesUpdatedNextFrame();
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _materialStatesController.removeListener(_onMaterialStatesUpdatedNextFrame);
    _materialStatesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.isDisabled ? null : _focusNode,
      canRequestFocus: !widget.isDisabled,
      descendantsAreFocusable: false,
      onFocusChange: _onFocusChanged,
      child: MouseRegion(
        cursor: _isHovering && !_isDisabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: _onStartHover,
        onExit: _onEndHover,
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: widget.child,
        ),
      ),
    );
  }

  void _onMaterialStatesUpdatedNextFrame() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      _onMaterialStatesUpdated();
    });
  }

  void _onMaterialStatesUpdated() {
    widget.onStatesChanged(_materialStatesController.value);
  }

  void _onFocusChanged(bool value) {
    if (widget.isDisabled) return;
    _materialStatesController.update(MaterialState.focused, value);
  }

  void _onStartHover(PointerEnterEvent event) {
    if (widget.isDisabled) return;
    if (_materialStatesController.value.contains(MaterialState.hovered)) return;
    _materialStatesController.update(MaterialState.hovered, true);
    _onMaterialStatesUpdated();
  }

  void _onEndHover(PointerExitEvent event) {
    if (widget.isDisabled) return;
    _materialStatesController.update(MaterialState.hovered, false);
    _onMaterialStatesUpdated();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.isDisabled) return;
    _materialStatesController.update(MaterialState.pressed, true);
    _onMaterialStatesUpdated();
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.isDisabled) return;
    _materialStatesController.update(MaterialState.pressed, false);
    _onMaterialStatesUpdated();
  }

  void _onTapCancel() {
    if (widget.isDisabled) return;
    _materialStatesController.update(MaterialState.pressed, false);
    _onMaterialStatesUpdated();
  }
}
