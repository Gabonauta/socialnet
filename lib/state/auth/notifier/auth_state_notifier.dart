import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socialnet/state/auth/backend/authenticator.dart';
import 'package:socialnet/state/auth/models/auth_results.dart';
import 'package:socialnet/state/auth/models/auth_state.dart';
import 'package:socialnet/state/user_info/backend/user_info_storage.dart';

import '../../post/typedefs/user_id.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }
  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.logInWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
      state = AuthState(
        result: result,
        isLoading: false,
        userId: userId,
      );
    }
  }

  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWitFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
      state = AuthState(
        result: result,
        isLoading: false,
        userId: userId,
      );
    }
  }

  Future<void> saveUserInfo({required UserId userId}) {
    return _userInfoStorage.saveUserInfo(
      userId: userId,
      displayName: _authenticator.displayName,
      email: _authenticator.email,
    );
  }
}
