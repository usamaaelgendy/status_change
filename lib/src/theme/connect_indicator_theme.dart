import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:status_change/src/theme/status_change_theme.dart';

@immutable
class ConnectorThemeData with Diagnosticable {
  const ConnectorThemeData({
    this.space,
    this.thickness,
  });

  final double? space;

  final double? thickness;

  ConnectorThemeData copyWith({
    Color? color,
    double? space,
    double? thickness,
  }) {
    return ConnectorThemeData(
      space: space ?? this.space,
      thickness: thickness ?? this.thickness,
    );
  }

  @override
  int get hashCode {
    return Object.hash(
      space,
      thickness,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ConnectorThemeData &&
        other.space == space &&
        other.thickness == thickness;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('space', space, defaultValue: null))
      ..add(DoubleProperty('thickness', thickness, defaultValue: null));
  }
}

class ConnectorTheme extends InheritedTheme {
  const ConnectorTheme({
    Key? key,
    required this.data,
    required Widget child,
  })  : super(key: key, child: child);

  final ConnectorThemeData data;

  static ConnectorThemeData of(BuildContext context) {
    final connectorTheme =
        context.dependOnInheritedWidgetOfExactType<ConnectorTheme>();
    return connectorTheme?.data ?? StatusChangeTheme.of(context).connectorTheme;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ancestorTheme =
        context.findAncestorWidgetOfExactType<ConnectorTheme>();
    return identical(this, ancestorTheme)
        ? child
        : ConnectorTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(ConnectorTheme oldWidget) => data != oldWidget.data;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    data.debugFillProperties(properties);
  }
}

mixin ThemedConnectorComponent on Widget {
  Axis? get direction;

  Axis getEffectiveDirection(BuildContext context) {
    return direction ?? StatusChangeTheme.of(context).direction;
  }

  double? get thickness;

  double getEffectiveThickness(BuildContext context) {
    return thickness ?? ConnectorTheme.of(context).thickness ?? 2.0;
  }

  double? get space;

  double? getEffectiveSpace(BuildContext context) {
    return space ?? ConnectorTheme.of(context).space;
  }

  double? get indent;

  double getEffectiveIndent(BuildContext context) {
    return indent ?? 0.0;
  }

  double? get endIndent;

  double getEffectiveEndIndent(BuildContext context) {
    return endIndent ?? 0.0;
  }

  Color? get color;

  Color? getEffectiveColor(BuildContext context) {
    return color;
  }
}
