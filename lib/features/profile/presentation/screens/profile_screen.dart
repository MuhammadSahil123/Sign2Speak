import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:my_app_flutter/features/chatbot/presentation/providers/chat_provider.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import 'package:my_app_flutter/shared/widgets/glass_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // User Profile Info
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.surface,
                          child: Text('A', style: TextStyle(fontSize: 40, color: AppColors.text, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primary,
                          child: const Icon(LucideIcons.camera, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(user?.name ?? 'Alex Rivera', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.text)),
                  Text(user?.email ?? 'alex.rivera@example.com', style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Performance Summary
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem('Total Signs', '1,248', LucideIcons.hand),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryItem('Points', '850', LucideIcons.award),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Feedback Summary (Linked to State)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('AI Assistant Feedback', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 12),
            GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn('Positive', chatState.positiveFeedbackCount.toString(), AppColors.secondary),
                  Container(width: 1, height: 40, color: AppColors.border),
                  _buildStatColumn('Negative', chatState.negativeFeedbackCount.toString(), Colors.redAccent),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Settings List
            _buildSettingsTile(LucideIcons.settings, 'General Settings'),
            _buildSettingsTile(LucideIcons.bell, 'Notifications'),
            _buildSettingsTile(LucideIcons.shield, 'Privacy & Security'),
            _buildSettingsTile(LucideIcons.helpCircle, 'Help & Support'),
            
            const SizedBox(height: 32),
            
            // Logout
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => ref.read(authProvider.notifier).logout(),
                icon: const Icon(LucideIcons.logOut, size: 18),
                label: const Text('Logout'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.redAccent),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.text)),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textMuted, size: 20),
        title: Text(title, style: const TextStyle(color: AppColors.text, fontSize: 14)),
        trailing: const Icon(LucideIcons.chevronRight, color: AppColors.textMuted, size: 16),
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: AppColors.surface,
      ),
    );
  }
}
