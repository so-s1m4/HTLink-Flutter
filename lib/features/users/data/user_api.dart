import 'package:htlink/core/config/app_config.dart';
import 'package:htlink/core/network/api_client.dart';
import 'package:htlink/features/users/domain/user.dart';

class UserApi {
  UserApi({ApiClient? apiClient, AppConfig config = const AppConfig()})
    : _apiClient = apiClient ?? ApiClient(baseUrl: config.baseUrl),
      _config = config;

  final ApiClient _apiClient;
  final AppConfig _config;

  Future<User> getMyProfile({required String token}) async {
    if (_config.useMockData) {
      return User.fromJson(_mockUser);
    }

    final json = await _apiClient.getObject('/profile', token: token);
    return User.fromJson(json);
  }

  Future<User> getUserById(String id) async {
    if (_config.useMockData) {
      return User.fromJson({..._mockUser, 'id': id});
    }

    final json = await _apiClient.getObject('/users/$id');
    return User.fromJson(json);
  }
}

const Map<String, dynamic> _mockUser = {
  'id': 'ajhsgdhagsdhj',
  'username': 's1m4',
  'name': 'Maksym',
  'email': 'maksym@example.com',
  'description': 'Software Engineer',
  'class_': '4AHIF',
  'avatarUrl':
      'https://imgs.search.brave.com/xxEKnrrtk2VxGBTGGBQg23aoRn6Kj-MLBKAU86AyEr8/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wMjcv/OTUxLzEzMC9zbWFs/bC9hZnJpY2EtZ3V5/LTNkLWF2YXRhci1j/aGFyYWN0ZXItaWxs/dXN0cmF0aW9ucy1w/bmcucG5n',
  'links': {
    'github': 'https://github.com/so-s1m4',
    'linkedin': 'https://linkedin.com/in/s1m4',
    'twitter': 'https://twitter.com/s1m4',
    'telegram': 'https://t.me/s1m4',
    'website': 'https://s1m4.example.com',
  },
};
