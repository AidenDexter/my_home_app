import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../mock/presentation/mock_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MockPage(),
      theme: AppTheme.lightThemeData,
      darkTheme: AppTheme.darkThemeData,
    );
  }
}
