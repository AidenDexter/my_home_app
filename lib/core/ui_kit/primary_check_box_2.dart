// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../extension/src/theme_extension.dart';

@immutable
class PrimaryCheckbox2 extends StatefulWidget {
  static const double width = 20;
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final MouseCursor? mouseCursor;
  final Color? activeColor;
  final Color? activeBorderColor;
  final MaterialStateProperty<Color?>? fillColor;
  final Color? checkColor;
  final bool tristate;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final Color? focusColor;
  final Color? hoverColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final FocusNode? focusNode;
  final bool autofocus;
  final OutlinedBorder? shape;
  final BorderSide? side;

  const PrimaryCheckbox2({
    required this.value,
    required this.onChanged,
    this.tristate = false,
    this.mouseCursor,
    this.activeColor,
    this.activeBorderColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    super.key,
  }) : assert(tristate || value != null, '');

  @override
  State<PrimaryCheckbox2> createState() => _InspectrumCheckboxState();
}

class _InspectrumCheckboxState extends State<PrimaryCheckbox2> with TickerProviderStateMixin, ToggleableStateMixin {
  final _CheckboxPainter _painter = _CheckboxPainter();

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged;

  @override
  bool get tristate => widget.tristate;

  @override
  bool? get value => widget.value;

  bool? _previousValue;

  MaterialStateProperty<Color?> get _widgetFillColor => MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return widget.activeColor;
        }
        return null;
      });

  MaterialStateProperty<Color> get _defaultFillColor {
    final themeData = Theme.of(context);
    return MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return themeData.disabledColor;
      }
      if (states.contains(MaterialState.selected)) {
        return themeData.primaryColor;
      }
      return context.theme.commonColors.neutralgrey10;
    });
  }

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(PrimaryCheckbox2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value;
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_asserts_with_message
    assert(debugCheckHasMaterial(context));
    final themeData = Theme.of(context);
    final effectiveMaterialTapTargetSize = widget.materialTapTargetSize ??
        themeData.checkboxTheme.materialTapTargetSize ??
        themeData.materialTapTargetSize;
    final effectiveVisualDensity =
        widget.visualDensity ?? themeData.checkboxTheme.visualDensity ?? themeData.visualDensity;
    Size size;
    switch (effectiveMaterialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        size = const Size(kMinInteractiveDimension, kMinInteractiveDimension);
      case MaterialTapTargetSize.shrinkWrap:
        size = const Size(
          kMinInteractiveDimension - 8.0,
          kMinInteractiveDimension - 8.0,
        );
    }
    size += effectiveVisualDensity.baseSizeAdjustment;

    final effectiveMouseCursor = MaterialStateProperty.resolveWith<MouseCursor>(
      (states) =>
          MaterialStateProperty.resolveAs<MouseCursor?>(
            widget.mouseCursor,
            states,
          ) ??
          themeData.checkboxTheme.mouseCursor?.resolve(states) ??
          MaterialStateMouseCursor.clickable.resolve(states),
    );

    // Colors need to be resolved in selected and non selected states separately
    // so that they can be lerped between.
    final activeStates = states..add(MaterialState.selected);
    final inactiveStates = states..remove(MaterialState.selected);
    final effectiveActiveColor = widget.fillColor?.resolve(activeStates) ??
        _widgetFillColor.resolve(activeStates) ??
        themeData.checkboxTheme.fillColor?.resolve(activeStates) ??
        _defaultFillColor.resolve(activeStates);
    final effectiveInactiveColor = widget.fillColor?.resolve(inactiveStates) ??
        _widgetFillColor.resolve(inactiveStates) ??
        themeData.checkboxTheme.fillColor?.resolve(inactiveStates) ??
        _defaultFillColor.resolve(inactiveStates);

    final focusedStates = states..add(MaterialState.focused);
    final effectiveFocusOverlayColor = widget.overlayColor?.resolve(focusedStates) ??
        widget.focusColor ??
        themeData.checkboxTheme.overlayColor?.resolve(focusedStates) ??
        themeData.focusColor;

    final hoveredStates = states..add(MaterialState.hovered);
    final effectiveHoverOverlayColor = widget.overlayColor?.resolve(hoveredStates) ??
        widget.hoverColor ??
        themeData.checkboxTheme.overlayColor?.resolve(hoveredStates) ??
        themeData.hoverColor;

    final activePressedStates = activeStates..add(MaterialState.pressed);
    final effectiveActivePressedOverlayColor = widget.overlayColor?.resolve(activePressedStates) ??
        themeData.checkboxTheme.overlayColor?.resolve(activePressedStates) ??
        effectiveActiveColor.withAlpha(kRadialReactionAlpha);

    final inactivePressedStates = inactiveStates..add(MaterialState.pressed);
    final effectiveInactivePressedOverlayColor = widget.overlayColor?.resolve(inactivePressedStates) ??
        themeData.checkboxTheme.overlayColor?.resolve(inactivePressedStates) ??
        effectiveActiveColor.withAlpha(kRadialReactionAlpha);

    final effectiveCheckColor =
        widget.checkColor ?? themeData.checkboxTheme.checkColor?.resolve(states) ?? const Color(0xFFFFFFFF);

    return Semantics(
      checked: widget.value ?? false,
      child: buildToggleable(
        mouseCursor: effectiveMouseCursor,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        size: size,
        painter: _painter
          ..position = position
          ..reaction = reaction
          ..reactionFocusFade = reactionFocusFade
          ..reactionHoverFade = reactionHoverFade
          ..inactiveReactionColor = effectiveInactivePressedOverlayColor
          ..reactionColor = effectiveActivePressedOverlayColor
          ..hoverColor = effectiveHoverOverlayColor
          ..focusColor = effectiveFocusOverlayColor
          ..splashRadius = widget.splashRadius ?? themeData.checkboxTheme.splashRadius ?? kRadialReactionRadius
          ..downPosition = downPosition
          ..isFocused = states.contains(MaterialState.focused)
          ..isHovered = states.contains(MaterialState.hovered)
          ..activeColor = effectiveActiveColor
          ..inactiveColor = effectiveInactiveColor
          ..checkColor = effectiveCheckColor
          ..value = value
          ..previousValue = _previousValue
          ..shape = widget.shape ??
              themeData.checkboxTheme.shape ??
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(1)),
              )
          ..side = _resolveSide(widget.side) ?? _resolveSide(themeData.checkboxTheme.side),
      ),
    );
  }

  BorderSide? _resolveSide(BorderSide? side) {
    if (side is MaterialStateBorderSide) {
      if (states.contains(MaterialState.selected)) {
        return MaterialStateProperty.resolveAs<BorderSide?>(side, states)?.copyWith(color: widget.activeBorderColor);
      }
      return MaterialStateProperty.resolveAs<BorderSide?>(side, states);
    }
    if (!states.contains(MaterialState.selected)) return side;

    return null;
  }
}

const double _kEdgeSize = PrimaryCheckbox2.width;
const double _kStrokeWidth = 2;

class _CheckboxPainter extends ToggleablePainter {
  Color get checkColor => _checkColor!;
  set checkColor(Color value) {
    if (_checkColor == value) {
      return;
    }
    _checkColor = value;
    notifyListeners();
  }

  bool? get value => _value;
  set value(bool? value) {
    if (_value == value) {
      return;
    }
    _value = value;
    notifyListeners();
  }

  bool? get previousValue => _previousValue;
  set previousValue(bool? value) {
    if (_previousValue == value) {
      return;
    }
    _previousValue = value;
    notifyListeners();
  }

  OutlinedBorder get shape => _shape!;
  set shape(OutlinedBorder value) {
    if (_shape == value) {
      return;
    }
    _shape = value;
    notifyListeners();
  }

  BorderSide? get side => _side;
  set side(BorderSide? value) {
    if (_side == value) {
      return;
    }
    _side = value;
    notifyListeners();
  }

  Color? _checkColor;
  bool? _value;
  bool? _previousValue;

  OutlinedBorder? _shape;
  BorderSide? _side;

  @override
  void paint(Canvas canvas, Size size) {
    paintRadialReaction(canvas: canvas, origin: size.center(Offset.zero));

    final strokePaint = _createStrokePaint();
    final origin = size / 2.0 - const Size.square(_kEdgeSize) / 2.0 as Offset;
    final status = position.status;
    final tNormalized = status == AnimationStatus.forward || status == AnimationStatus.completed
        ? position.value
        : 1.0 - position.value;

    // Four cases: false to null, false to true, null to false, true to false
    if (previousValue == false || value == false) {
      final t = value == false ? 1.0 - tNormalized : tNormalized;
      final outer = _outerRectAt(origin, t);
      final paint = Paint()..color = _colorAt(t);

      if (t <= 0.5) {
        final border = side ?? BorderSide(width: 2, color: paint.color);
        _drawBox(canvas, outer, paint, border, true);
      } else {
        _drawBox(canvas, outer, paint, side, true);
        final tShrink = (t - 0.5) * 2.0;
        if (previousValue == null || value == null) {
          _drawDash(canvas, origin, tShrink, strokePaint);
        } else {
          _drawCheck(canvas, origin, tShrink, strokePaint);
        }
      }
    } else {
      // Two cases: null to true, true to null
      final outer = _outerRectAt(origin, 1);
      final paint = Paint()..color = _colorAt(1);

      _drawBox(canvas, outer, paint, side, true);
      if (tNormalized <= 0.5) {
        final tShrink = 1.0 - tNormalized * 2.0;
        if (previousValue ?? false) {
          _drawCheck(canvas, origin, tShrink, strokePaint);
        } else {
          _drawDash(canvas, origin, tShrink, strokePaint);
        }
      } else {
        final tExpand = (tNormalized - 0.5) * 2.0;
        if (value ?? false) {
          _drawCheck(canvas, origin, tExpand, strokePaint);
        } else {
          _drawDash(canvas, origin, tExpand, strokePaint);
        }
      }
    }
  }

  // The square outer bounds of the checkbox at t, with the specified origin.
  // At t == 0.0, the outer rect's size is _kEdgeSize (Checkbox.width)
  // At t == 0.5, .. is _kEdgeSize - _kStrokeWidth
  // At t == 1.0, .. is _kEdgeSize
  Rect _outerRectAt(Offset origin, double t) {
    final inset = 1.0 - (t - 0.5).abs() * 2.0;
    final size = _kEdgeSize - inset * _kStrokeWidth;
    final rect = Rect.fromLTWH(origin.dx + inset, origin.dy + inset, size, size);
    return rect;
  }

  // The checkbox's border color if value == false, or its fill color when
  // value == true or null.
  Color _colorAt(double t) => t >= 0.25 ? activeColor : Color.lerp(inactiveColor, activeColor, t * 4.0)!;

  // White stroke used to paint the check and dash.
  Paint _createStrokePaint() => Paint()
    ..color = checkColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = _kStrokeWidth
    ..strokeCap = StrokeCap.round;

  void _drawBox(
    Canvas canvas,
    Rect outer,
    Paint paint,
    BorderSide? side,
    bool fill,
  ) {
    if (fill) {
      canvas.drawPath(shape.getOuterPath(outer), paint);
    }
    if (side != null) {
      shape.copyWith(side: side).paint(canvas, outer);
    }
  }

  void _drawCheck(Canvas canvas, Offset origin, double t, Paint paint) {
    // ignore: prefer_asserts_with_message
    assert(t >= 0.0 && t <= 1.0);
    // As t goes from 0.0 to 1.0, animate the two check mark strokes from the
    // short side to the long side.
    final path = Path();
    // const start = Offset(_kEdgeSize * 0.15, _kEdgeSize * 0.45);
    // const mid = Offset(_kEdgeSize * 0.4, _kEdgeSize * 0.7);
    // const end = Offset(_kEdgeSize * 0.85, _kEdgeSize * 0.25);
    const start = Offset(_kEdgeSize * 0.7333350, _kEdgeSize * 0.3250000);
    const mid = Offset(_kEdgeSize * 0.4125000, _kEdgeSize * 0.6458350);
    const end = Offset(_kEdgeSize * 0.2666665, _kEdgeSize * 0.5000000);
    if (t < 0.5) {
      final strokeT = t * 2.0;
      final drawMid = Offset.lerp(start, mid, strokeT)!;
      path
        ..moveTo(origin.dx + start.dx, origin.dy + start.dy)
        ..lineTo(origin.dx + drawMid.dx, origin.dy + drawMid.dy);
    } else {
      final strokeT = (t - 0.5) * 2.0;
      final drawEnd = Offset.lerp(mid, end, strokeT)!;
      path
        ..moveTo(origin.dx + start.dx, origin.dy + start.dy)
        ..lineTo(origin.dx + mid.dx, origin.dy + mid.dy)
        ..lineTo(origin.dx + drawEnd.dx, origin.dy + drawEnd.dy);
    }
    canvas.drawPath(path, paint);
  }

  void _drawDash(Canvas canvas, Offset origin, double t, Paint paint) {
    // ignore: prefer_asserts_with_message
    assert(t >= 0.0 && t <= 1.0);
    // As t goes from 0.0 to 1.0, animate the horizontal line from the
    // mid point outwards.
    const start = Offset(_kEdgeSize * 0.2, _kEdgeSize * 0.5);
    const mid = Offset(_kEdgeSize * 0.5, _kEdgeSize * 0.5);
    const end = Offset(_kEdgeSize * 0.8, _kEdgeSize * 0.5);
    final drawStart = Offset.lerp(start, mid, 1.0 - t)!;
    final drawEnd = Offset.lerp(mid, end, t)!;
    canvas.drawLine(origin + drawStart, origin + drawEnd, paint);
  }
}
