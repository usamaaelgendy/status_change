import 'package:flutter/material.dart';
import 'package:status_change/src/theme/indicator_theme.dart';

mixin PositionedIndicator on Widget {
  double get position;
  double getEffectivePosition(BuildContext context) {
    return position ?? IndicatorTheme.of(context).position ?? .5;
  }
}

abstract class Indicator extends StatelessWidget
    with PositionedIndicator, ThemedIndicatorComponent {
  const Indicator({
    Key key,
    this.size,
    this.color,
    this.border,
    this.position,
    this.child,
  })  : assert(size == null || size >= 0),
        assert(position == null || 0 <= position && position <= 1),
        super(key: key);

  @override
  final double size;

  @override
  final Color color;

  @override
  final double position;

  final BoxBorder border;

  final Widget child;
}

class DotIndicator extends Indicator {
  const DotIndicator({
    Key key,
    double size,
    Color color,
    double position,
    this.border,
    this.child,
  }) : super(
          key: key,
          size: size,
          color: color,
          position: position,
        );

  final BoxBorder border;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final effectiveSize = getEffectiveSize(context);
    final effectiveColor = getEffectiveColor(context);
    return Center(
      child: Container(
        width: effectiveSize ?? ((child == null) ? 15.0 : null),
        height: effectiveSize ?? ((child == null) ? 15.0 : null),
        child: child,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: effectiveColor,
          border: border,
        ),
      ),
    );
  }
}

class OutlinedDotIndicator extends Indicator {
  const OutlinedDotIndicator({
    Key key,
    double size,
    Color color,
    double position,
    this.backgroundColor,
    this.borderWidth = 2.0,
    this.child,
  })  : assert(size == null || size >= 0),
        assert(position == null || 0 <= position && position <= 1),
        super(
          key: key,
          size: size,
          color: color,
          position: position,
        );

  final Color backgroundColor;

  final double borderWidth;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DotIndicator(
      size: size,
      color: backgroundColor ?? Colors.transparent,
      position: position,
      border: Border.all(
        color: color ?? getEffectiveColor(context),
        width: borderWidth,
      ),
      child: child,
    );
  }
}
