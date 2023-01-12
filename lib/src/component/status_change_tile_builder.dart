import 'package:flutter/material.dart';
import 'package:status_change/status_change.dart';

typedef IndexedValueBuilder<T> = T Function(int index);

class StatusChangeTileBuilder {
  factory StatusChangeTileBuilder.connected({
    required int itemCount,
    StatusChangeNodeAlign? nodeAlign,
    IndexedWidgetBuilder? nameWidgetBuilder,
    IndexedWidgetBuilder? contentWidgetBuilder,
    IndexedWidgetBuilder? indicatorWidgetBuilder,
    Function(int index)? lineWidgetBuilder,
    Function(int index)? itemWidth,
  }) {
    return StatusChangeTileBuilder(
      itemCount: itemCount,
      nodeAlign: nodeAlign ,
      contentsBuilder: nameWidgetBuilder,
      oppositeContentsBuilder: contentWidgetBuilder,
      indicatorBuilder: indicatorWidgetBuilder,
      startConnectorBuilder: _createConnectedStartConnectorBuilder(
        connectorBuilder: lineWidgetBuilder,
      ),
      endConnectorBuilder: _createConnectedEndConnectorBuilder(
        connectorBuilder: lineWidgetBuilder,
        itemCount: itemCount,
      ),
      itemExtentBuilder: itemWidth,
    );
  }

  factory StatusChangeTileBuilder({
    required int itemCount,
    StatusChangeNodeAlign? nodeAlign,
    IndexedWidgetBuilder? contentsBuilder,
    IndexedWidgetBuilder? oppositeContentsBuilder,
    IndexedWidgetBuilder? indicatorBuilder,
    IndexedWidgetBuilder? startConnectorBuilder,
    IndexedWidgetBuilder? endConnectorBuilder,
    Function(int index)? itemExtentBuilder,
    Function(int index)? nodePositionBuilder,
    Function(int index)? nodeItemOverlapBuilder,
  }) {
    final effectiveContentsBuilder = _createAlignedContentsBuilder(
      contentsBuilder: contentsBuilder!,
      oppositeContentsBuilder: oppositeContentsBuilder,
    );
    final effectiveOppositeContentsBuilder = _createAlignedContentsBuilder(
      contentsBuilder: oppositeContentsBuilder!,
      oppositeContentsBuilder: contentsBuilder,
    );

    return StatusChangeTileBuilder._(
      (context, index) {
        final tile = StatusChangeTile(
          mainAxisExtent: itemExtentBuilder?.call(index),
          node: TimelineNode(
            startConnector: startConnectorBuilder?.call(context, index),
            endConnector: endConnectorBuilder?.call(context, index),
            position: nodePositionBuilder?.call(index),
            indicator: indicatorBuilder!.call(context, index),
          ),
          nodeAlign: nodeAlign ?? StatusChangeNodeAlign.basic,
          contents: effectiveContentsBuilder(context, index),
          oppositeContents: effectiveOppositeContentsBuilder(context, index),
        );

        return tile;
      },
      itemCount: itemCount,
    );
  }

  const StatusChangeTileBuilder._(
    this._builder, {
    required this.itemCount,
  })  : assert(itemCount >= 0);

  final IndexedWidgetBuilder _builder;
  final int itemCount;

  Widget build(BuildContext context, index) {
    return _builder(context, index);
  }

  static IndexedWidgetBuilder _createConnectedStartConnectorBuilder({
    required Function(int index)? connectorBuilder,
  }) {
    return (context, index) {
      if (index == 0) {
        if (connectorBuilder != null) {
          return connectorBuilder.call(index) ?? Text('');
        }
      }

      return connectorBuilder?.call(index);
    };
  }

  static IndexedWidgetBuilder _createConnectedEndConnectorBuilder({
    required Function(int index)? connectorBuilder,
    required int itemCount,
  }) {
    return (context, index) {
      if (index == itemCount - 1) {
        return connectorBuilder?.call(index + 1);
      }

      return connectorBuilder?.call(index + 1);
    };
  }

  static IndexedWidgetBuilder _createAlignedContentsBuilder({
    required IndexedWidgetBuilder contentsBuilder,
    IndexedWidgetBuilder? oppositeContentsBuilder,
  }) {
    return (context, index) {
      return contentsBuilder.call(context, index);
    };
  }
}
