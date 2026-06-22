import 'package:htlink/core/config/app_config.dart';
import 'package:htlink/features/users/data/user_api.dart';
import 'package:htlink/features/users/data/user_local_storage.dart';
import 'package:htlink/features/users/domain/user.dart';

class UserRepository {
  UserRepository({
    UserApi? api,
    UserLocalStorage? localStorage,
    AppConfig config = const AppConfig(),
  }) : _api = api ?? UserApi(config: config),
       _localStorage = localStorage ?? UserLocalStorage(),
       _config = config;

  final UserApi _api;
  final UserLocalStorage _localStorage;
  final AppConfig _config;

  Future<User> getUserById(String id) async {
    try {
      final user = await _api.getUserById(id);
      await _localStorage.saveUser(user);
      return user;
    } catch (_) {
      return _localStorage.getUser(id);
    }
  }

  Future<User> getMyProfile() async {
    try {
      final user = await _api.getMyProfile(token: _config.authToken);
      await _localStorage.saveCurrentUser(user);
      return user;
    } catch (_) {
      return _localStorage.getCurrentUser();
    }
  }
}
