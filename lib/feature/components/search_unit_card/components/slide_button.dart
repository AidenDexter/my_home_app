import 'package:flutter/material.dart';

import '../../../../core/extension/extensions.dart';

class SlideButton extends StatelessWidget {
  const SlideButton({
    required this.onTap,
    required this.isNotVisible,
    required this.icon,
    super.key,
  });

  final VoidCallback onTap;
  final bool isNotVisible;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isNotVisible ? 0.0 : 1.0,
      duration: context.theme.durations.pageElements,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: isNotVisible ? null : onTap,
            child: Ink(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.commonColors.black.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(4),
              child: Icon(
                icon,
                color: context.theme.commonColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
