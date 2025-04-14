// repositories/user_repository.dart
import '../models/user.dart';
import '../services/user_service.dart';

class UserRepository {
  UserRepository(this._userService);
  final UserService _userService;

  Future<void> addUser(String userId, Map<String, dynamic> data) {
    return _userService.createUser(userId, data);
  }

  Future<Map<String, dynamic>?> fetchUser(String userId) {
    return _userService.getUser(userId);
  }

  Future<void> modifyUser(String userId, Map<String, dynamic> data) {
    return _userService.updateUser(userId, data);
  }

  Future<void> removeUser(String userId) {
    return _userService.deleteUser(userId);
  }

  Future<String> registerUser({
    required String email,
    required String username,
    required String password,
  }) {
    return _userService.registerUser(
        email: email, username: username, password: password);
  }

  String? get currentUserId => _userService.currentUserId;

  bool get isLoggedIn => _userService.isLoggedIn;

  Future<User?> getCurrentUser() async {
    if (!isLoggedIn || currentUserId == null) return null;

    final docData = await fetchUser(currentUserId!);
    return docData != null ? User.fromMap(docData) : null;
  }
}
