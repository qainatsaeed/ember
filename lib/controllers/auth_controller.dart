import '../models/user.dart';
import '../providers/user_provider.dart';

// These controllers are shared accross the app in various screens
class AuthController {
  factory AuthController.init(UserProvider userProvider) {
    if (_instance != null) {
      return _instance!;
    }

    _instance = AuthController._(userProvider);

    return _instance!;
  }

  AuthController._(this._userProvider);

  static AuthController? _instance;

  static AuthController get instance {
    if (_instance == null) {
      throw Exception('AuthController is not initialized');
    }

    return _instance!;
  }

  final UserProvider _userProvider;

  User? get currentUser => _userProvider.currentUser;
  bool get isLoggedIn => _userProvider.isLoggedIn;

  Future<void> fetchUserProfile() async {
    await _userProvider.fetchUserProfile();
  }

  Future<String> registerUser({
    required String email,
    required String username,
    required String password,
  }) async {
    return _userProvider.registerUser(
      email: email,
      username: username,
      password: password,
    );
  }
}
