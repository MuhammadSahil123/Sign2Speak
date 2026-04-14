import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app_flutter/core/theme/app_theme.dart';
import 'package:my_app_flutter/features/navigation/main_navigation.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Sign2SpeakApp(),
    ),
  );
}

class Sign2SpeakApp extends StatelessWidget {
  const Sign2SpeakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign2Speak',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainNavigation(),
    );
  }
}
