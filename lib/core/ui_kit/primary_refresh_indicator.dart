import 'package:flutter/material.dart';

import '../extension/extensions.dart';

class PrimaryRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  const PrimaryRefreshIndicator({required this.child, required this.onRefresh, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    return RefreshIndicator(
      child: child,
      backgroundColor: colors.white,
      color: colors.green100,
      onRefresh: onRefresh,
    );
  }
}
