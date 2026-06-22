import 'package:flutter/material.dart';
import 'package:htlink/core/utils/widget_list_utils.dart';
import 'package:htlink/features/menu/presentation/menu_block.dart';
import 'package:htlink/features/menu/presentation/menu_item.dart';
import 'package:htlink/features/users/data/user_repository.dart';
import 'package:htlink/features/users/presentation/profile_page.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  Future<void> openProfile(BuildContext context) async {
    try {
      final profile = await UserRepository().getMyProfile();

      if (!context.mounted) return;

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => Profile(user: profile)));
    } catch (error) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not load profile: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black26),
      height: double.infinity,
      width: double.infinity,
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.fromLTRB(500, 16, 500, 16)
          : const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: ListView(
        children: WidgetListUtils.insertDividers([
          Menublock(
            children: [
              MenuItem(
                title: 'My Profile',
                icon: Icons.person,
                onTap: () => openProfile(context),
              ),
              MenuItem(
                title: 'Logout',
                icon: Icons.logout,
                onTap: () {
                  // Logout logic
                },
              ),
            ],
          ),
          const Menublock(
            title: 'Projects',
            children: [
              MenuItem(title: 'Notifications', icon: Icons.notifications),
              MenuItem(title: 'Requests', icon: Icons.handshake),
            ],
          ),
          const Menublock(
            title: 'Settings',
            children: [
              MenuItem(title: 'Theme', icon: Icons.light_mode),
              MenuItem(
                title: 'Notifications',
                icon: Icons.notifications_active,
              ),
            ],
          ),
          const Menublock(
            title: 'Privacy & Security',
            children: [
              MenuItem(title: 'Password', icon: Icons.password),
              MenuItem(title: '2FA', icon: Icons.security),
            ],
          ),
          const Menublock(
            title: 'Support',
            children: [
              MenuItem(title: 'Report a bug', icon: Icons.bug_report),
              MenuItem(title: 'Become a beta tester', icon: Icons.engineering),
            ],
          ),
        ], const SizedBox(height: 15)),
      ),
    );
  }
}
