import 'dart:convert';

import 'package:htlink/core/storage/local_storage.dart';
import 'package:htlink/features/users/domain/user.dart';

class UserLocalStorage {
  UserLocalStorage({LocalStorage? localStorage})
    : _localStorage = localStorage ?? LocalStorage();

  static const String _currentUserKey = 'current_user';

  final LocalStorage _localStorage;

  Future<void> saveUser(User user) async {
    await _localStorage.setString('user_${user.id}', jsonEncode(user.toJson()));
  }

  Future<void> saveCurrentUser(User user) async {
    await Future.wait([
      saveUser(user),
      _localStorage.setString(_currentUserKey, user.id),
    ]);
  }

  Future<User> getUser(String id) async {
    final rawJson = await _localStorage.getString('user_$id');

    if (rawJson == null) {
      throw Exception('User not found');
    }

    return User.fromJson(jsonDecode(rawJson) as Map<String, dynamic>);
  }

  Future<User> getCurrentUser() async {
    final id = await _localStorage.getString(_currentUserKey);

    if (id == null) {
      throw Exception('Current user not found');
    }

    return getUser(id);
  }
}
