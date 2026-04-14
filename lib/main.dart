import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app_flutter/core/theme/app_theme.dart';
import 'package:my_app_flutter/features/auth/presentation/providers/auth_provider.dart';
import 'package:my_app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:my_app_flutter/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:my_app_flutter/features/navigation/main_navigation.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Sign2SpeakApp(),
    ),
  );
}

class Sign2SpeakApp extends ConsumerWidget {
  const Sign2SpeakApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Sign2Speak',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: _getHome(authState),
    );
  }

  Widget _getHome(AuthState authState) {
    if (authState.user != null) {
      return const MainNavigation();
    }
    if (authState.hasFinishedOnboarding) {
      return const LoginScreen();
    }
    return const OnboardingScreen();
  }
}
