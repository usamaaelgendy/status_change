import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'connect_indicator_theme.dart';
import 'indicator_theme.dart';

class StatusChangeTheme extends StatelessWidget {
  const StatusChangeTheme({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final StatusChangeThemeData data;

  final Widget child;

  static final StatusChangeThemeData _kFallbackTheme =
      StatusChangeThemeData.fallback();

  static StatusChangeThemeData of(BuildContext context) {
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return inheritedTheme?.theme?.data ?? _kFallbackTheme;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: IndicatorTheme(
        data: data.indicatorTheme,
        child: child,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<StatusChangeThemeData>('data', data,
        showName: false));
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    Key? key,
    required this.theme,
    required Widget child,
  })  : assert(theme != null),
        super(key: key, child: child);

  final StatusChangeTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ancestorTheme =
        context.findAncestorWidgetOfExactType<_InheritedTheme>();
    return identical(this, ancestorTheme)
        ? child
        : StatusChangeTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}

@immutable
class StatusChangeThemeData with Diagnosticable {
  factory StatusChangeThemeData({
    Axis? direction,
    IndicatorThemeData? indicatorTheme,
    ConnectorThemeData? connectorTheme,
  }) {
    direction ??= Axis.vertical;
    indicatorTheme ??= IndicatorThemeData();
    connectorTheme ??= ConnectorThemeData();
    return StatusChangeThemeData.raw(
      direction: direction,
      indicatorTheme: indicatorTheme,
      connectorTheme: connectorTheme,
    );
  }
  factory StatusChangeThemeData.fallback() => StatusChangeThemeData.vertical();

  const StatusChangeThemeData.raw({
    required this.direction,
    required this.indicatorTheme,
    required this.connectorTheme,
  })  : assert(direction != null),
        assert(indicatorTheme != null),
        assert(connectorTheme != null);

  factory StatusChangeThemeData.vertical() => StatusChangeThemeData(
        direction: Axis.vertical,
      );

  /// A default horizontal theme.
  factory StatusChangeThemeData.horizontal() => StatusChangeThemeData(
        direction: Axis.horizontal,
      );

  /// {@macro timelines.direction}
  final Axis direction;

  final IndicatorThemeData indicatorTheme;

  final ConnectorThemeData connectorTheme;

  /// Creates a copy of this theme but with the given fields replaced with the new values.
  StatusChangeThemeData copyWith({
    Axis? direction,
    Color? color,
    double? indicatorPosition,
    IndicatorThemeData? indicatorTheme,
    ConnectorThemeData? connectorTheme,
  }) {
    return StatusChangeThemeData.raw(
      direction: direction ?? this.direction,
      indicatorTheme: indicatorTheme ?? this.indicatorTheme,
      connectorTheme: connectorTheme ?? this.connectorTheme,
    );
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is StatusChangeThemeData &&
        other.direction == direction &&
        other.indicatorTheme == indicatorTheme &&
        other.connectorTheme == connectorTheme;
  }

  @override
  int get hashCode {
    final values = <Object>[
      direction,
      indicatorTheme,
      connectorTheme,
    ];
    return hashList(values);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final defaultData = StatusChangeThemeData.fallback();
    properties
      ..add(DiagnosticsProperty<Axis>('direction', direction,
          defaultValue: defaultData.direction, level: DiagnosticLevel.debug))
      ..add(DiagnosticsProperty<IndicatorThemeData>(
        'indicatorTheme',
        indicatorTheme,
        defaultValue: defaultData.indicatorTheme,
        level: DiagnosticLevel.debug,
      ))
      ..add(DiagnosticsProperty<ConnectorThemeData>(
        'connectorTheme',
        connectorTheme,
        defaultValue: defaultData.connectorTheme,
        level: DiagnosticLevel.debug,
      ));
  }
}
