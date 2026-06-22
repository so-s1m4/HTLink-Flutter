import 'package:flutter/material.dart';
import 'package:htlink/features/home/presentation/home_page.dart';
import 'package:htlink/features/menu/presentation/menu.dart';
import 'package:htlink/features/navigation/data/navbar_notifier.dart';
import 'package:htlink/features/navigation/presentation/navbar.dart';
import 'package:htlink/features/projects/data/project_repository.dart';
import 'package:htlink/features/projects/domain/project.dart';
import 'package:htlink/features/projects/presentation/project_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _projectRepository = ProjectRepository();

  List<Project> projects = [];
  bool isLoadingProjects = true;
  String? projectsError;

  @override
  void initState() {
    super.initState();
    getProjects();
  }

  Future<void> getProjects() async {
    try {
      final loadedProjects = await _projectRepository.getMyProjects();

      if (!mounted) return;

      setState(() {
        projects = loadedProjects;
        isLoadingProjects = false;
        projectsError = null;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoadingProjects = false;
        projectsError = error.toString();
      });
    }
  }

  Widget buildProjectsPage() {
    if (isLoadingProjects) {
      return const Center(child: CircularProgressIndicator());
    }

    if (projectsError != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Could not load projects:\n$projectsError'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoadingProjects = true;
                  projectsError = null;
                });

                getProjects();
              },
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    }

    return Projectpage(projects: projects);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const Homepage(),
      const Homepage(),
      buildProjectsPage(),
      const Menu(),
    ];

    return MaterialApp(
      title: 'HTLink',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: ValueListenableBuilder<int>(
        valueListenable: selectedIndexNotifier,
        builder: (context, selectedIndex, _) {
          return Scaffold(
            body: IndexedStack(index: selectedIndex, children: pages),
            bottomNavigationBar: const Navbar(),
          );
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
