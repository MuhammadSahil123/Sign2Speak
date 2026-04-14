import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  bool? feedback; // true for positive, false for negative

  ChatMessage({
    required this.text,
    this.isUser = false,
    DateTime? timestamp,
    this.feedback,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isTyping;
  final int positiveFeedbackCount;
  final int negativeFeedbackCount;
  final List<String> currentSuggestions;

  ChatState({
    required this.messages,
    this.isTyping = false,
    this.positiveFeedbackCount = 0,
    this.negativeFeedbackCount = 0,
    this.currentSuggestions = const [],
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
    int? positiveFeedbackCount,
    int? negativeFeedbackCount,
    List<String>? currentSuggestions,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      positiveFeedbackCount: positiveFeedbackCount ?? this.positiveFeedbackCount,
      negativeFeedbackCount: negativeFeedbackCount ?? this.negativeFeedbackCount,
      currentSuggestions: currentSuggestions ?? this.currentSuggestions,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(ChatState(messages: [
    ChatMessage(text: "Hello! I'm your Sign2Speak Assistant. How can I help you today?"),
  ]));

  void sendMessage(String text) async {
    final userMessage = ChatMessage(text: text, isUser: true);
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isTyping: true,
      currentSuggestions: [],
    );

    // Simulate AI response
    await Future.delayed(const Duration(seconds: 1));
    
    String response = "I understand you're asking about '$text'. To improve your detection, try to keep your hands within the guide frame and ensure good lighting.";
    
    state = state.copyWith(
      messages: [...state.messages, ChatMessage(text: response)],
      isTyping: false,
    );
  }

  void updateFeedback(int messageIndex, bool isPositive) {
    final newMessages = [...state.messages];
    if (messageIndex >= 0 && messageIndex < newMessages.length) {
      newMessages[messageIndex].feedback = isPositive;
      
      state = state.copyWith(
        messages: newMessages,
        positiveFeedbackCount: state.positiveFeedbackCount + (isPositive ? 1 : 0),
        negativeFeedbackCount: state.negativeFeedbackCount + (isPositive ? 0 : 1),
      );
    }
  }

  void updateSuggestions(String input) {
    if (input.isEmpty) {
      state = state.copyWith(currentSuggestions: []);
      return;
    }

    final allSuggestions = [
      "How to improve detection?",
      "Why is my gesture not working?",
      "Tips for better accuracy",
      "Lighting requirements",
      "Hand positioning guide",
    ];

    final filtered = allSuggestions
        .where((s) => s.toLowerCase().contains(input.toLowerCase()))
        .toList();

    state = state.copyWith(currentSuggestions: filtered);
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});
