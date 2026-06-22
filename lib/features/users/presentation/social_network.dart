import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialNetwork extends StatelessWidget {
  const SocialNetwork({super.key, this.type, required this.link});

  final String link;
  final String? type;

  String get title {
    switch (type?.toLowerCase()) {
      case 'github':
        return 'GitHub';
      case 'linkedin':
        return 'LinkedIn';
      case 'twitter':
        return 'Twitter';
      case 'telegram':
        return 'Telegram';
      case 'website':
        return 'Website';
      default:
        return 'Link';
    }
  }

  IconData get icon {
    switch (type?.toLowerCase()) {
      case 'github':
        return Icons.code;
      case 'linkedin':
        return Icons.business;
      case 'twitter':
        return Icons.chat;
      case 'telegram':
        return Icons.telegram;
      case 'website':
        return Icons.public;
      default:
        return Icons.link;
    }
  }

  Future<void> openLink(BuildContext context) async {
    final uri = Uri.parse(link);

    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open $link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => openLink(context),
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
                child: Icon(icon, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
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
    );
  }
}
