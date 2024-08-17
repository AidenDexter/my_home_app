import 'package:flutter/material.dart';

import '../extension/extensions.dart';

class PrimaryCheckBox extends StatelessWidget {
  final bool isChecked;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool?) onChanged;
  const PrimaryCheckBox({required this.isChecked, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      side: BorderSide(color: context.theme.commonColors.neutralgrey10),
      activeColor: context.theme.commonColors.green100,
      checkColor: context.theme.commonColors.white,
      value: isChecked,
      onChanged: onChanged,
    );
  }
}
