import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:status_change/src/helper/util.dart';

import '../../status_change.dart';

/// Align the timeline node within the timeline tile.
enum StatusChangeNodeAlign {
  start,

  end,

  basic,
}

class StatusChangeTile extends StatelessWidget {
  const StatusChangeTile({
    Key? key,
    this.direction,
    required this.node,
    this.nodeAlign = StatusChangeNodeAlign.basic,
    this.nodePosition,
    this.contents,
    this.oppositeContents,
    this.mainAxisExtent,
    this.crossAxisExtent,
  })  : assert(
          nodeAlign == StatusChangeNodeAlign.basic ||
              (nodeAlign != StatusChangeNodeAlign.basic &&
                  nodePosition == null),
          'Cannot provide both a nodeAlign and a nodePosition',
        ),
        assert(nodePosition == null || nodePosition >= 0),
        super(key: key);

  final Axis? direction;

  final Widget node;

  final StatusChangeNodeAlign nodeAlign;

  final double? nodePosition;

  final Widget? contents;

  final Widget? oppositeContents;

  final double? mainAxisExtent;

  /// the child's height.
  final double? crossAxisExtent;

  double _getEffectiveNodePosition(BuildContext context) {
    if (nodeAlign == StatusChangeNodeAlign.start) return 0.0;
    if (nodeAlign == StatusChangeNodeAlign.end) return 1.0;
    var nodePosition = this.nodePosition;
    nodePosition ??= (node is StatusChangeTileNode)
        ? (node as StatusChangeTileNode).getEffectivePosition(context)
        : .5;
    return nodePosition;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: reduce direction check
    final direction = this.direction ?? StatusChangeTheme.of(context).direction;
    final nodeFlex = _getEffectiveNodePosition(context) * kFlexMultiplier;

    var minNodeExtent =
        StatusChangeTheme.of(context).indicatorTheme.size ?? 0.0;
    var items = [
      if (nodeFlex > 0)
        Expanded(
          flex: nodeFlex.toInt(),
          child: Align(
            alignment: direction == Axis.vertical
                ? AlignmentDirectional.centerEnd
                : Alignment.bottomCenter,
            child: oppositeContents ?? SizedBox.shrink(),
          ),
        ),
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: direction == Axis.vertical ? minNodeExtent : 0.0,
          minHeight: direction == Axis.vertical ? 0.0 : minNodeExtent,
        ),
        child: node,
      ),
      if (nodeFlex < kFlexMultiplier)
        Expanded(
          flex: (kFlexMultiplier - nodeFlex).toInt(),
          child: Align(
            alignment: direction == Axis.vertical
                ? AlignmentDirectional.centerStart
                : Alignment.topCenter,
            child: contents ?? SizedBox.shrink(),
          ),
        ),
    ];

    var result;
    switch (direction) {
      case Axis.vertical:
        result = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items,
        );

        if (mainAxisExtent != null) {
          result = SizedBox(
            width: crossAxisExtent,
            height: mainAxisExtent,
            child: result,
          );
        } else {
          result = IntrinsicHeight(
            child: result,
          );

          if (crossAxisExtent != null) {
            result = SizedBox(
              width: crossAxisExtent,
              child: result,
            );
          }
        }
        break;
      case Axis.horizontal:
        result = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items,
        );
        if (mainAxisExtent != null) {
          result = SizedBox(
            width: mainAxisExtent,
            height: crossAxisExtent,
            child: result,
          );
        } else {
          result = IntrinsicWidth(
            child: result,
          );

          if (crossAxisExtent != null) {
            result = SizedBox(
              height: crossAxisExtent,
              child: result,
            );
          }
        }
        break;
      default:
        throw ArgumentError.value(direction, '$direction is invalid.');
    }

    result = Align(
      child: result,
    );

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
