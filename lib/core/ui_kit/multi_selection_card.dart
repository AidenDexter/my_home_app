import 'package:flutter/material.dart';

import '../extension/extensions.dart';

class MultiSelectionCard<T> extends StatelessWidget {
  final void Function(T) onTap;
  final bool isSelected;
  final T value;
  final String title;
  final Widget? icon;

  const MultiSelectionCard({
    required this.isSelected,
    required this.onTap,
    required this.value,
    required this.title,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;

    return AnimatedContainer(
      duration: context.theme.durations.pageElements,
      decoration: BoxDecoration(
        color: isSelected ? colors.green100 : colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? colors.green100 : colors.neutralgrey10,
        ),
      ),
      child: Material(
        color: colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => onTap(value),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  SizedBox.square(
                    dimension: 18,
                    child: icon,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  title,
                  style: context.theme.commonTextStyles.body1.copyWith(
                    color: isSelected ? colors.white : colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
