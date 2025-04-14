import 'package:flutter/material.dart';

import '../models/user.dart';
import '../repo/user_repo.dart';
import '../utils/utils.dart';

class UserProvider extends ChangeNotifier {
  UserProvider(this._userRepository);
  final UserRepository _userRepository;

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool get isLoggedIn => _userRepository.isLoggedIn;

  bool _hasUserProfile = false;

  bool get hasUserProfile => _hasUserProfile;

  Future<void> fetchUserProfile() async {
    try {
      _currentUser = await _userRepository.getCurrentUser();
      _hasUserProfile = _currentUser != null;
      notifyListeners(); // Notify UI to rebuild
    } catch (e) {
      warn('Error fetching user profile: $e');
    }
  }

  Future<String> registerUser({
    required String email,
    required String username,
    required String password,
  }) async {
    final message = await _userRepository.registerUser(
      email: email,
      username: username,
      password: password,
    );

    if (message == 'success') {
      await fetchUserProfile();
      return message;
    } else {
      warn('Error registering user: $message');
    }
    notifyListeners();
    return message;
  }
}
