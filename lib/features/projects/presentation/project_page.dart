import 'package:flutter/material.dart';
import 'package:htlink/features/projects/domain/project.dart';
import 'package:htlink/features/projects/presentation/project_preview.dart';

class Projectpage extends StatelessWidget {
  const Projectpage({super.key, required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            for (final project in projects)
              ProjectPreview(
                projectTitle: project.title,
                projectDescription: project.description ?? '',
                projectImageUrl: project.imageUrl ?? '',
                category: project.category,
              ),
          ],
        ),
      ),
    );
  }
}
