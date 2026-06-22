class Project {
  const Project({
    required this.id,
    required this.title,
    this.description,
    this.category,
    this.imageUrl,
  });

  final String id;
  final String title;
  final String? description;
  final String? category;
  final String? imageUrl;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'].toString(),
      title: json['title'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}
