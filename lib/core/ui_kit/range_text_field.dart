import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extension/extensions.dart';

const _radius = 8.0;

class RangeTextField extends StatelessWidget {
  final String suffix;
  final String label;
  final TextEditingController controller;
  final bool isError;
  const RangeTextField({
    required this.suffix,
    required this.label,
    required this.controller,
    this.isError = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(_radius)),
        color: isError ? const Color(0xFFFFF1F2) : colors.white,
        border: Border.all(
          color: isError ? const Color(0xFFFCA5A5) : colors.neutralgrey10,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                style: context.theme.commonTextStyles.body1,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  disabledBorder: _border(),
                  enabledBorder: _border(),
                  focusedBorder: _border(),
                  labelText: label,
                  labelStyle: context.theme.commonTextStyles.rangeTextFieldLabel,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: isError ? null : colors.neutralgrey5,
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(_radius)),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                suffix,
                style: context.theme.commonTextStyles.body2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputBorder _border() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(_radius)),
    );
  }
}
