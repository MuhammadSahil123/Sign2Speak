import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../dashboard/presentation/screens/dashboard_screen.dart';
import '../chatbot/presentation/screens/chatbot_screen.dart';
import '../camera/presentation/screens/camera_screen.dart';
import '../history/presentation/screens/history_screen.dart';
import '../profile/presentation/screens/profile_screen.dart';
import 'package:my_app_flutter/core/constants/colors.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

class MainNavigation extends ConsumerWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    final screens = [
      const DashboardScreen(),
      const CameraScreen(),
      const HistoryScreen(),
      const ChatBotScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => ref.read(navigationIndexProvider.notifier).state = index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.home, size: 20),
              activeIcon: Icon(LucideIcons.home, color: AppColors.primary, size: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.camera, size: 20),
              activeIcon: Icon(LucideIcons.camera, color: AppColors.primary, size: 24),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.history, size: 20),
              activeIcon: Icon(LucideIcons.history, color: AppColors.primary, size: 24),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.messageSquare, size: 20),
              activeIcon: Icon(LucideIcons.messageSquare, color: AppColors.primary, size: 24),
              label: 'AI Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.user, size: 20),
              activeIcon: Icon(LucideIcons.user, color: AppColors.primary, size: 24),
              label: 'Profile',
            ),
          ],
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
        ),
      ),
    );
  }
}
