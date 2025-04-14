// services/user_service.dart

abstract class UserService {
  Future<void> createUser(String userId, Map<String, dynamic> data);
  Future<Map<String, dynamic>?> getUser(String userId);
  Future<void> updateUser(String userId, Map<String, dynamic> data);
  Future<void> deleteUser(String userId);
  Future<String> registerUser({
    required String email,
    required String username,
    required String password,
  });
  String? get currentUserId;
  bool get isLoggedIn;
}
