import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../extension/extensions.dart';

class SingleSelectionCard<T> extends StatelessWidget {
  final void Function(T) onTap;
  final T groupValue;
  final T value;
  final String title;

  const SingleSelectionCard({
    required this.groupValue,
    required this.onTap,
    required this.value,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = groupValue == value;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? context.theme.commonColors.green100 : context.theme.commonColors.darkGrey30,
            ),
          ),
          child: InkWell(
            onTap: () => onTap(value),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(title, style: context.theme.commonTextStyles.body1),
            ),
          ),
        ),
        if (isSelected)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: context.theme.commonColors.green100,
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  color: context.theme.commonColors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.all(3),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.theme.commonColors.green100,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ).animate().scale(),
          ),
      ],
    );
  }
}