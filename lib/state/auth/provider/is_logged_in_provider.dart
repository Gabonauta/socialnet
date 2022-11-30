import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialnet/state/auth/models/auth_results.dart';
import 'package:socialnet/state/auth/provider/auth_state_provider.dart';

final isLoggedInProvider = Provider((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == AuthResult.success;
});
