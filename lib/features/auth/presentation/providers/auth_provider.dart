import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  final String email;
  final String name;

  UserProfile({required this.email, required this.name});
}

class AuthState {
  final UserProfile? user;
  final bool isLoading;
  final String? error;
  final bool hasFinishedOnboarding;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.hasFinishedOnboarding = false,
  });

  AuthState copyWith({
    UserProfile? user,
    bool? isLoading,
    String? error,
    bool? hasFinishedOnboarding,
    bool clearUser = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      error: error, // If not provided, it clears
      hasFinishedOnboarding: hasFinishedOnboarding ?? this.hasFinishedOnboarding,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  void finishOnboarding() {
    state = state.copyWith(hasFinishedOnboarding: true);
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'admin@sign2speak.ai' && password == 'admin123') {
      state = state.copyWith(
        isLoading: false,
        user: UserProfile(email: email, name: 'Alex Rivera'),
        hasFinishedOnboarding: true,
      );
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        error: 'Invalid email or password',
      );
      return false;
    }
  }

  Future<void> signup(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(seconds: 1));

    state = state.copyWith(
      isLoading: false,
      user: UserProfile(email: email, name: name),
      hasFinishedOnboarding: true,
    );
  }

  void logout() {
    state = state.copyWith(clearUser: true);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
