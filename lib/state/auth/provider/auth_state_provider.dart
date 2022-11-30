import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialnet/state/auth/models/auth_state.dart';
import 'package:socialnet/state/auth/notifier/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
