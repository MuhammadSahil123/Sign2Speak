import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import 'package:my_app_flutter/shared/widgets/glass_card.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.15),
              ),
            ),
          ).animate().fadeIn(duration: 1000.ms),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  
                  // App Icon / Logo
                  GlassCard(
                    padding: const EdgeInsets.all(24),
                    borderRadius: 30,
                    child: const Icon(
                      LucideIcons.bot,
                      size: 60,
                      color: AppColors.primary,
                    ),
                  ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),

                  const SizedBox(height: 48),

                  // Title
                  const Text(
                    'Communicate Without Limits',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                      height: 1.2,
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

                  const SizedBox(height: 16),

                  // Subtitle
                  const Text(
                    'AI-powered real-time sign language translation at your fingertips.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textMuted,
                    ),
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),

                  const Spacer(flex: 3),

                  // Features list
                  _buildFeatureRow(LucideIcons.camera, 'Real-time Camera Detection'),
                  const SizedBox(height: 16),
                  _buildFeatureRow(LucideIcons.messageSquare, 'Smart AI Assistant'),
                  const SizedBox(height: 16),
                  _buildFeatureRow(LucideIcons.history, 'Full Translation History'),

                  const Spacer(flex: 2),

                  // Action Buttons
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(authProvider.notifier).finishOnboarding();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
                    },
                    child: const Text(
                      'I already have an account',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary, size: 20),
        const SizedBox(width: 16),
        Text(
          label,
          style: const TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1);
  }
}
