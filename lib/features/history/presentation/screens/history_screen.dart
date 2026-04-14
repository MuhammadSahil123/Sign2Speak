import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import '../../core/constants/colors.dart';
import '../domain/models/translation_history.dart';
import '../../../shared/widgets/glass_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<TranslationHistory> _history = [
    TranslationHistory(id: '1', text: 'How are you?', timestamp: DateTime.now().subtract(const Duration(minutes: 45)), accuracy: 0.98),
    TranslationHistory(id: '2', text: 'Thank you very much', timestamp: DateTime.now().subtract(const Duration(hours: 2)), accuracy: 0.95),
    TranslationHistory(id: '3', text: 'Where is the exit?', timestamp: DateTime.now().subtract(const Duration(days: 1)), accuracy: 0.92),
    TranslationHistory(id: '4', text: 'I need help', timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 4)), accuracy: 0.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation History'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(LucideIcons.filter, size: 20)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search translations...',
                prefixIcon: const Icon(LucideIcons.search, size: 18),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(LucideIcons.messageSquare, color: AppColors.primary, size: 20),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.text, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('MMM dd, hh:mm a').format(item.timestamp),
                                style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${(item.accuracy * 100).toInt()}%',
                              style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const Text('Accuracy', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
