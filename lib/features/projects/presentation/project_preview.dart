import 'package:flutter/material.dart';
import 'package:htlink/core/theme/app_styles.dart';

class ProjectPreview extends StatelessWidget {
  const ProjectPreview({
    super.key,
    required this.projectTitle,
    required this.projectDescription,
    required this.projectImageUrl,
    this.category,
  });

  final String projectTitle;
  final String projectDescription;
  final String projectImageUrl;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 16 / 14,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: blockStyle,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    projectImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.2,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      projectTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      projectDescription,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
              if (category != null)
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category!,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              const Positioned(
                bottom: 15,
                right: 16,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
