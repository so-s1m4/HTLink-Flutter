import 'package:flutter/material.dart';
import 'package:htlink/features/projects/data/project_repository.dart';
import 'package:htlink/features/projects/presentation/project_page.dart';
import 'package:htlink/features/users/domain/user.dart';
import 'package:htlink/features/users/presentation/social_network.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});

  final User user;

  Future<void> openProjects(BuildContext context) async {
    try {
      final projects = await ProjectRepository().getProjectsByUserId(
        userId: user.id,
      );

      if (!context.mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => Projectpage(projects: projects)),
      );
    } catch (error) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not load profile: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasAvatar =
        user.avatarUrl != null && user.avatarUrl!.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.username != null ? '@${user.username}' : 'Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (user.description != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    user.description!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                children: [
                                  if (user.className != null)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.class_),
                                        const SizedBox(width: 8),
                                        Text(
                                          user.className!,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.email),
                                      const SizedBox(width: 8),
                                      Text(
                                        user.email,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 15,
                    top: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF272727),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.purple,
                        backgroundImage: hasAvatar
                            ? NetworkImage(user.avatarUrl!)
                            : null,
                        child: !hasAvatar
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => openProjects(context),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.work, size: 20),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Projects',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(Icons.open_in_new, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Social Networks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              for (final type in [
                'github',
                'linkedin',
                'twitter',
                'telegram',
                'website',
              ])
                if (user.links != null && user.links!.containsKey(type))
                  SocialNetwork(link: user.links![type]!, type: type),
            ],
          ),
        ),
      ),
    );
  }
}
