import 'package:flutter/material.dart';
import 'package:status_change/src/helper/util.dart';
import 'package:status_change/status_change.dart';


mixin StatusChangeTileNode on Widget {
  double? get position;
  double getEffectivePosition(BuildContext context) {
    return position ?? .5;
  }
}

class TimelineNode extends StatelessWidget with StatusChangeTileNode {
  const TimelineNode({
    Key? key,
    this.direction,
    this.startConnector,
    this.endConnector,
    required this.indicator,
    this.indicatorPosition,
    this.position,
  })  : assert(indicatorPosition == null ||
            0 <= indicatorPosition && indicatorPosition <= 1),
        super(key: key);

  TimelineNode.simple({
    Key? key,
    Axis? direction,
    Color? color,
    double? lineThickness,
    double? nodePosition,
    double? indicatorPosition,
    double? indicatorSize,
    Widget? indicatorChild,
    double? indent,
    double? endIndent,
    bool drawStartConnector = true,
    bool drawEndConnector = true,
  }) : this(
          key: key,
          direction: direction,
          startConnector: drawStartConnector
              ? SolidLineConnector(
                  direction: direction,
                  color: color,
                  thickness: lineThickness,
                  indent: indent,
                  endIndent: endIndent,
                )
              : null,
          endConnector: drawEndConnector
              ? SolidLineConnector(
                  direction: direction,
                  color: color,
                  thickness: lineThickness,
                  indent: indent,
                  endIndent: endIndent,
                )
              : null,
          indicator: DotIndicator(
            child: indicatorChild,
            position: indicatorPosition,
            size: indicatorSize,
            color: color,
          ),
          indicatorPosition: indicatorPosition,
          position: nodePosition,
        );

  final Axis? direction;

  final Widget? startConnector;

  final Widget? endConnector;

  final Widget indicator;

  final double? indicatorPosition;

  @override
  final double? position;

  double _getEffectiveIndicatorPosition(BuildContext context) {
    var indicatorPosition = this.indicatorPosition;
    indicatorPosition ??= (indicator is PositionedIndicator)
        ? (indicator as PositionedIndicator).getEffectivePosition(context)
        : .5;
    return indicatorPosition;
  }

  bool _getEffectiveOverlap(BuildContext context) {
    var overlap = false;
    return overlap;
  }

  @override
  Widget build(BuildContext context) {
    final direction = this.direction ?? StatusChangeTheme.of(context).direction;
    final overlap = _getEffectiveOverlap(context);
    // ignore: todo
    // TODO: support both flex and logical pixel
    final indicatorFlex = _getEffectiveIndicatorPosition(context);
    Widget line = indicator;
    final lineItems = [
      if (indicatorFlex > 0)
        Flexible(
          flex: (indicatorFlex * kFlexMultiplier).toInt(),
          child: startConnector ?? TransparentConnector(),
        ),
      if (!overlap) indicator,
      if (indicatorFlex < 1)
        Flexible(
          flex: ((1 - indicatorFlex) * kFlexMultiplier).toInt(),
          child: endConnector ?? TransparentConnector(),
        ),
    ];

    switch (direction) {
      case Axis.vertical:
        line = Column(
          mainAxisSize: MainAxisSize.min,
          children: lineItems,
        );
        break;
      case Axis.horizontal:
        line = Row(
          mainAxisSize: MainAxisSize.min,
          children: lineItems,
        );
        break;
    }

    Widget result;
    if (overlap) {
      Widget positionedIndicator = indicator;
      final positionedIndicatorItems = [
        if (indicatorFlex > 0)
          Flexible(
            flex: (indicatorFlex * kFlexMultiplier).toInt(),
            child: TransparentConnector(),
          ),
        indicator,
        Flexible(
          flex: ((1 - indicatorFlex) * kFlexMultiplier).toInt(),
          child: TransparentConnector(),
        ),
      ];

      switch (direction) {
        case Axis.vertical:
          positionedIndicator = Column(
            mainAxisSize: MainAxisSize.min,
            children: positionedIndicatorItems,
          );
          break;
        case Axis.horizontal:
          positionedIndicator = Row(
            mainAxisSize: MainAxisSize.min,
            children: positionedIndicatorItems,
          );
          break;
      }

      result = Stack(
        alignment: Alignment.center,
        children: [
          line,
          positionedIndicator,
        ],
      );
    } else {
      result = line;
    }

    if (StatusChangeTheme.of(context).direction != direction) {
      result = StatusChangeTheme(
        data: StatusChangeTheme.of(context).copyWith(
          direction: direction,
        ),
        child: result,
      );
    }

    return result;
  }
}
