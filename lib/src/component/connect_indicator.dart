import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:status_change/status_change.dart';

abstract class Connector extends StatelessWidget with ThemedConnectorComponent {
  const Connector({
    Key? key,
    this.direction,
    this.space,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  })  : assert(thickness == null || thickness >= 0.0),
        assert(space == null || space >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0),
        super(key: key);

  @override
  final Axis? direction;
  @override
  final double? space;
  @override
  final double? thickness;

  @override
  final double? indent;

  @override
  final double? endIndent;

  @override
  final Color? color;
}

class SolidLineConnector extends Connector {
  const SolidLineConnector({
    Key? key,
    Axis? direction,
    double? thickness,
    double? space,
    double? indent,
    double? endIndent,
    Color? color,
  }) : super(
          key: key,
          thickness: thickness,
          space: space,
          indent: indent,
          endIndent: endIndent,
          color: color,
        );

  @override
  Widget build(BuildContext context) {
    final direction = getEffectiveDirection(context);
    final thickness = getEffectiveThickness(context);
    final color = getEffectiveColor(context);
    final space = getEffectiveSpace(context);
    final indent = getEffectiveIndent(context);
    final endIndent = getEffectiveEndIndent(context);

    switch (direction) {
      case Axis.vertical:
        return _ConnectorIndent(
          direction: direction,
          indent: indent,
          endIndent: endIndent,
          space: space,
          child: Container(
            width: thickness,
            color: color,
          ),
        );
      case Axis.horizontal:
        return _ConnectorIndent(
          direction: direction,
          indent: indent,
          endIndent: endIndent,
          space: space,
          child: Container(
            height: thickness,
            color: color,
          ),
        );
    }

  }
}

class DecoratedLineConnector extends Connector {
  const DecoratedLineConnector({
    Key? key,
    Axis? direction,
    double? thickness,
    double? space,
    double? indent,
    double? endIndent,
    this.decoration,
  }) : super(
          key: key,
          thickness: thickness,
          space: space,
          indent: indent,
          endIndent: endIndent,
        );

  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    final direction = getEffectiveDirection(context);
    final thickness = getEffectiveThickness(context);
    final space = getEffectiveSpace(context);
    final indent = getEffectiveIndent(context);
    final endIndent = getEffectiveEndIndent(context);

    switch (direction) {
      case Axis.vertical:
        return _ConnectorIndent(
          direction: direction,
          indent: indent,
          endIndent: endIndent,
          space: space,
          child: Container(
            width: thickness,
            decoration: decoration,
          ),
        );
      case Axis.horizontal:
        return _ConnectorIndent(
          direction: direction,
          indent: indent,
          endIndent: endIndent,
          space: space,
          child: Container(
            height: thickness,
            decoration: decoration,
          ),
        );
    }

  }
}

class TransparentConnector extends Connector {
  const TransparentConnector({
    Key? key,
    Axis? direction,
    double? indent,
    double? endIndent,
    double? space,
  }) : super(
          key: key,
          direction: direction,
          indent: indent,
          endIndent: endIndent,
          space: space,
        );

  @override
  Widget build(BuildContext context) {
    return _ConnectorIndent(
      direction: getEffectiveDirection(context),
      indent: getEffectiveIndent(context),
      endIndent: getEffectiveEndIndent(context),
      space: getEffectiveSpace(context),
      child: Container(),
    );
  }
}

class _ConnectorIndent extends StatelessWidget {
  const _ConnectorIndent({
    Key? key,
    required this.direction,
    required this.space,
    required this.indent,
    required this.endIndent,
    required this.child,
  })  : assert(direction != null),
        assert(space == null || space >= 0),
        assert(indent == null || indent >= 0),
        assert(endIndent == null || endIndent >= 0),
        assert(child != null),
        super(key: key);

  final Axis direction;
  final double? space;

  final double indent;

  final double endIndent;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: direction == Axis.vertical ? space : null,
      height: direction == Axis.vertical ? null : space,
      child: Center(
        child: Padding(
          padding: direction == Axis.vertical
              ? EdgeInsetsDirectional.only(
                  top: indent,
                  bottom: endIndent,
                )
              : EdgeInsetsDirectional.only(
                  start: indent,
                  end: endIndent,
                ),
          child: child,
        ),
      ),
    );
  }
}
