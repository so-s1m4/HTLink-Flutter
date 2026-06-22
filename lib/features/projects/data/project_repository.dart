import 'package:htlink/core/config/app_config.dart';
import 'package:htlink/features/projects/data/project_local_storage.dart';
import 'package:htlink/features/projects/data/projects_api.dart';
import 'package:htlink/features/projects/domain/project.dart';

class ProjectRepository {
  ProjectRepository({
    ProjectsApi? api,
    ProjectLocalStorage? localStorage,
    AppConfig config = const AppConfig(),
  }) : _api = api ?? ProjectsApi(config: config),
       _localStorage = localStorage ?? ProjectLocalStorage(),
       _config = config;

  final ProjectsApi _api;
  final ProjectLocalStorage _localStorage;
  final AppConfig _config;

  Future<Project> getProjectById(String id) async {
    try {
      final project = await _api.getProjectById(id: id);
      await _localStorage.saveProject(project);
      return project;
    } catch (_) {
      return _localStorage.getProject(id);
    }
  }

  Future<List<Project>> getProjectsByUserId({required String userId}) async {
    try {
      final projects = await _api.getProjectsByUserId(userId: userId);
      await _localStorage.saveProjects(projects, userId: userId);
      return projects;
    } catch (_) {
      return _localStorage.getProjectsByUserId(userId);
    }
  }

  Future<List<Project>> getMyProjects() async {
    try {
      final projects = await _api.getMyProjects(token: _config.authToken);
      await _localStorage.saveProjects(projects);
      return projects;
    } catch (_) {
      return _localStorage.getMyProjects();
    }
  }
}
