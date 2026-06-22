import 'package:htlink/core/config/app_config.dart';
import 'package:htlink/core/network/api_client.dart';
import 'package:htlink/features/projects/domain/project.dart';

class ProjectsApi {
  ProjectsApi({ApiClient? apiClient, AppConfig config = const AppConfig()})
    : _apiClient = apiClient ?? ApiClient(baseUrl: config.baseUrl),
      _config = config;

  final ApiClient _apiClient;
  final AppConfig _config;

  Future<List<Project>> getProjectsByUserId({required String userId}) async {
    if (_config.useMockData) {
      return _mockProjects.map(Project.fromJson).toList();
    }

    final json = await _apiClient.getList('/users/$userId/projects');
    return json.map(Project.fromJson).toList();
  }

  Future<Project> getProjectById({required String id}) async {
    if (_config.useMockData) {
      final project = _mockProjects.firstWhere(
        (project) => project['id'] == id,
        orElse: () => _mockProjects.first,
      );

      return Project.fromJson(project);
    }

    final json = await _apiClient.getObject('/projects/$id');
    return Project.fromJson(json);
  }

  Future<List<Project>> getMyProjects({required String token}) async {
    if (_config.useMockData) {
      return _mockProjects.map(Project.fromJson).toList();
    }

    final json = await _apiClient.getList('/profile/projects', token: token);
    return json.map(Project.fromJson).toList();
  }
}

const List<Map<String, dynamic>> _mockProjects = [
  {
    'id': '1',
    'title': 'Project 1',
    'description': 'Description of Project 1',
    'category': 'Category 1',
    'imageUrl':
        'https://imgs.search.brave.com/8YaCpO1gXOcY99Z4fp_pVK8-iFT6qJoY8GWCGoKD44Q/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9pMC53/cC5jb20vcGljanVt/Ym8uY29tL3dwLWNv/bnRlbnQvdXBsb2Fk/cy9oaWdoLWZhc2hp/b24td2ludGVyLXN0/dWRpby1waG90b3No/b290LXdpdGgteW91/bmctbWFuLWluLXdp/bnRlci1qYWNrZXQt/ZnJlZS1waG90by5q/cGVnP3c9NjAwJnF1/YWxpdHk9ODA',
  },
  {
    'id': '2',
    'title': 'Project 2',
    'description': 'Description of Project 2',
    'category': 'Category 2',
    'imageUrl':
        'https://imgs.search.brave.com/8YaCpO1gXOcY99Z4fp_pVK8-iFT6qJoY8GWCGoKD44Q/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9pMC53/cC5jb20vcGljanVt/Ym8uY29tL3dwLWNv/bnRlbnQvdXBsb2Fk/cy9oaWdoLWZhc2hp/b24td2ludGVyLXN0/dWRpby1waG90b3No/b290LXdpdGgteW91/bmctbWFuLWluLXdp/bnRlci1qYWNrZXQt/ZnJlZS1waG90by5q/cGVnP3c9NjAwJnF1/YWxpdHk9ODA',
  },
];
