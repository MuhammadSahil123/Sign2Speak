import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../shared/widgets/glass_card.dart';
import '../widgets/stats_card.dart';
import '../../chatbot/presentation/providers/chat_provider.dart';
import '../../../core/constants/colors.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final totalFeedback = chatState.positiveFeedbackCount + chatState.negativeFeedbackCount;
    final positivePercentage = totalFeedback > 0 
        ? (chatState.positiveFeedbackCount / totalFeedback) 
        : 0.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign2Speak',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                      ),
                      Text(
                        'Welcome back, Alex',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.bell, color: AppColors.textMuted, size: 20),
                      ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.primary,
                        child: Text('A', style: TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Live Camera Card
              GlassCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(LucideIcons.camera, color: AppColors.primary, size: 40),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Real-time Detection',
                      style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Start translating gestures instantly',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to Camera
                        },
                        child: const Text('Start Translating'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Stats Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
                children: const [
                  StatsCard(label: 'Translations', value: '1.2k', icon: LucideIcons.layers),
                  StatsCard(label: 'Accuracy', value: '98.5%', icon: LucideIcons.target, iconColor: AppColors.secondary),
                  StatsCard(label: 'Sessions', value: '24', icon: LucideIcons.clock, iconColor: AppColors.accent),
                ],
              ),
              const SizedBox(height: 24),

              // Feedback Analytics
              const Text(
                'Feedback Analytics',
                style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GlassCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('User Satisfaction', style: TextStyle(color: AppColors.text.withOpacity(0.8))),
                        Text('${(positivePercentage * 100).toInt()}%', 
                          style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: positivePercentage,
                        minHeight: 8,
                        backgroundColor: AppColors.border,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildFeedbackMini(LucideIcons.thumbsUp, AppColors.secondary, 'Positive: ${chatState.positiveFeedbackCount}'),
                        const SizedBox(width: 20),
                        _buildFeedbackMini(LucideIcons.thumbsDown, Colors.redAccent, 'Negative: ${chatState.negativeFeedbackCount}'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // AI Suggestions
              const Text(
                'AI Smart Suggestions',
                style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSuggestionCard('Improve Lighting', 'Detection works best in bright light', LucideIcons.sun),
                    _buildSuggestionCard('Hand Distance', 'Keep hands approx. 1ft from camera', LucideIcons.move),
                    _buildSuggestionCard('Slow Down', 'Try making gestures more slowly', LucideIcons.zap),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackMini(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
      ],
    );
  }

  Widget _buildSuggestionCard(String title, String desc, IconData icon) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accent, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 13)),
                Text(desc, style: const TextStyle(color: AppColors.textMuted, fontSize: 10), maxLines: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
