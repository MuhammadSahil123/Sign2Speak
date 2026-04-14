import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/chat_provider.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import '../../../shared/widgets/glass_card.dart';

class ChatBotScreen extends ConsumerStatefulWidget {
  const ChatBotScreen({super.key});

  @override
  ConsumerState<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends ConsumerState<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary,
              child: Icon(LucideIcons.bot, color: Colors.white, size: 18),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Assistant', style: TextStyle(fontSize: 16)),
                Text('Sign2Speak Helper', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              itemCount: chatState.messages.length + (chatState.isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == chatState.messages.length) {
                  return _buildTypingIndicator();
                }
                final message = chatState.messages[index];
                return _buildChatBubble(message, index);
              },
            ),
          ),
          
          // Suggestions while typing
          if (chatState.currentSuggestions.isNotEmpty)
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: chatState.currentSuggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = chatState.currentSuggestions[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      label: Text(suggestion, style: const TextStyle(fontSize: 12)),
                      onPressed: () {
                        _controller.text = suggestion;
                        ref.read(chatProvider.notifier).updateSuggestions(suggestion);
                      },
                      backgroundColor: AppColors.surface,
                      side: const BorderSide(color: AppColors.border),
                    ),
                  );
                },
              ),
            ),

          // Input Area
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
              color: AppColors.background,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (val) => ref.read(chatProvider.notifier).updateSuggestions(val),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(color: AppColors.textMuted),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: IconButton(
                    icon: const Icon(LucideIcons.send, color: Colors.white, size: 18),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        ref.read(chatProvider.notifier).sendMessage(_controller.text);
                        _controller.clear();
                        _scrollToBottom();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message, int index) {
    bool isUser = message.isUser;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUser) ...[
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.border,
                  child: Icon(LucideIcons.bot, color: AppColors.textMuted, size: 14),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  borderRadius: 16,
                  color: isUser ? AppColors.primary.withOpacity(0.2) : AppColors.surface.withOpacity(0.8),
                  child: Text(
                    message.text,
                    style: const TextStyle(color: AppColors.text, fontSize: 14),
                  ),
                ),
              ),
              if (isUser) ...[
                const SizedBox(width: 8),
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.primary,
                  child: Text('A', style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ],
            ],
          ),
          if (!isUser) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 36),
                _buildFeedbackIcon(index, true, message.feedback == true),
                const SizedBox(width: 12),
                _buildFeedbackIcon(index, false, message.feedback == false),
              ],
            ),
          ],
        ],
      ).animate().fadeIn(duration: 400.ms).slideX(begin: isUser ? 0.1 : -0.1),
    );
  }

  Widget _buildFeedbackIcon(int index, bool isPositive, bool isActive) {
    return GestureDetector(
      onTap: () => ref.read(chatProvider.notifier).updateFeedback(index, isPositive),
      child: Icon(
        isPositive ? LucideIcons.thumbsUp : LucideIcons.thumbsDown,
        size: 16,
        color: isActive 
            ? (isPositive ? AppColors.secondary : Colors.redAccent) 
            : AppColors.textMuted,
      ).animate(target: isActive ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.border,
            child: Icon(LucideIcons.bot, color: AppColors.textMuted, size: 14),
          ),
          const SizedBox(width: 8),
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            borderRadius: 16,
            child: Row(
              children: List.generate(3, (i) => 
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(color: AppColors.textMuted, shape: BoxShape.circle),
                ).animate(onPlay: (c) => c.repeat()).scale(
                  delay: (i * 100).ms,
                  duration: 600.ms,
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.2, 1.2),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
