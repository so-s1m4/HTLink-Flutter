import 'dart:convert';

import 'package:htlink/core/storage/local_storage.dart';
import 'package:htlink/features/projects/domain/project.dart';

class ProjectLocalStorage {
  ProjectLocalStorage({LocalStorage? localStorage})
    : _localStorage = localStorage ?? LocalStorage();

  static const String _myProjectsKey = 'my_projects';

  final LocalStorage _localStorage;

  Future<void> saveProject(Project project) async {
    await _localStorage.setString(
      'project_${project.id}',
      jsonEncode(project.toJson()),
    );
  }

  Future<void> saveProjects(List<Project> projects, {String? userId}) async {
    final encodedProjects = jsonEncode(
      projects.map((project) => project.toJson()).toList(),
    );

    await Future.wait([
      _localStorage.setString(_myProjectsKey, encodedProjects),
      for (final project in projects) saveProject(project),
      if (userId != null)
        _localStorage.setString(_projectsByUserKey(userId), encodedProjects),
    ]);
  }

  Future<Project> getProject(String id) async {
    final rawJson = await _localStorage.getString('project_$id');

    if (rawJson == null) {
      throw Exception('Project not found');
    }

    return Project.fromJson(jsonDecode(rawJson) as Map<String, dynamic>);
  }

  Future<List<Project>> getProjectsByUserId(String userId) async {
    final rawJson = await _localStorage.getString(_projectsByUserKey(userId));

    if (rawJson == null) {
      throw Exception('Projects not found');
    }

    return _decodeProjects(rawJson);
  }

  Future<List<Project>> getMyProjects() async {
    final rawJson = await _localStorage.getString(_myProjectsKey);

    if (rawJson == null) {
      throw Exception('My projects not found');
    }

    return _decodeProjects(rawJson);
  }

  String _projectsByUserKey(String userId) => 'projects_user_$userId';

  List<Project> _decodeProjects(String rawJson) {
    final decoded = jsonDecode(rawJson);

    if (decoded is! List) {
      throw const FormatException('Expected cached projects list');
    }

    return decoded.cast<Map<String, dynamic>>().map(Project.fromJson).toList();
  }
}
