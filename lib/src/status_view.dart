import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'component/status_change_tile_builder.dart';
import 'theme/status_change_theme.dart';

class StatusChange extends BoxScrollView {
  factory StatusChange.tileBuilder({
    Key? key,
    required StatusChangeTileBuilder builder,
    Axis? scrollDirection,
    StatusChangeThemeData? theme,
  }) {
    assert(builder.itemCount == null || builder.itemCount >= 0);
    return StatusChange.custom(
      key: key,
      childrenDelegate: SliverChildBuilderDelegate(
        builder.build,
        childCount: builder.itemCount,
      ),
      scrollDirection: scrollDirection,
      theme: theme,
    );
  }

  StatusChange.custom({
    Key? key,
    Axis? scrollDirection,
    required this.childrenDelegate,
    StatusChangeThemeData? theme,
  })  : assert(childrenDelegate != null),
        assert(scrollDirection == null || theme == null,
            'Cannot provide both a scrollDirection and a theme.'),
        this.theme = theme,
        super(
          key: key,
          scrollDirection: scrollDirection ?? theme?.direction ?? Axis.vertical,
        );

  final SliverChildDelegate childrenDelegate;

  final StatusChangeThemeData? theme;

  @override
  Widget buildChildLayout(BuildContext context) {
    Widget result;

    result = SliverList(delegate: childrenDelegate);

    var theme;
    if (this.theme != null) {
      theme = this.theme;
    } else if (scrollDirection != StatusChangeTheme.of(context).direction) {
      theme =
          StatusChangeTheme.of(context).copyWith(direction: scrollDirection);
    }

    if (theme != null) {
      return StatusChangeTheme(
        data: theme,
        child: result,
      );
    } else {
      return result;
    }
  }
}
