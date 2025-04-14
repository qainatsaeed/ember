// services/firebase_user_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user_service.dart';

class FirebaseUserService implements UserService {
  final _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> createUser(String userId, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(userId).set(data);
  }

  @override
  Future<String> registerUser({
    required String email,
    required String username,
    required String password,
  }) async {
    // check if uswername is already taken
    final usernameDoc = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    if (usernameDoc.docs.isNotEmpty) {
      return 'Username is already taken, please try another one';
    }

    UserCredential newUser;
    try {
      newUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(newUser.user!.uid).set({
        'id': newUser.user!.uid,
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email is already in use, please try another one';
      } else if (e.code == 'invalid-email') {
        return 'Please enter a valid email';
      } else if (e.code == 'weak-password') {
        return 'Password is too weak, please try another one';
      } else {
        return 'An error occured, please try again. Error code: ${e.code}';
      }
    } catch (e) {
      await _firebaseAuth.currentUser?.delete();

      // FirebaseCrashlytics.instance.recordError(e, StackTrace.current);

      return 'An error occured, please try again. Error code: ${e.toString()}';
    }
  }

  @override
  Future<Map<String, dynamic>?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc.exists ? doc.data() : null;
  }

  @override
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(userId).update(data);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  bool get isLoggedIn => _firebaseAuth.currentUser != null;
}
