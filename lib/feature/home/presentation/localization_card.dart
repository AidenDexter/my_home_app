import 'package:flutter/material.dart';

import '../../../core/extension/extensions.dart';

class LanguageChangeCard extends StatelessWidget {
  final String title;
  final Widget leading;
  const LanguageChangeCard({required this.title, required this.leading, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          leading,
          const Spacer(flex: 2),
          Text(
            title,
            style: context.theme.commonTextStyles.title3,
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
