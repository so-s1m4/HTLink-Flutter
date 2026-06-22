class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.description,
    this.avatarUrl,
    this.className,
    this.username,
    this.links,
  });

  final String id;
  final String name;
  final String email;
  final String? description;
  final String? avatarUrl;
  final String? className;
  final String? username;
  final Map<String, String>? links;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'] as String,
      username: json['username'] as String?,
      email: json['email'] as String,
      description: json['description'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      className: json['class_'] as String?,
      links: (json['links'] as Map?)?.map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'description': description,
      'avatarUrl': avatarUrl,
      'class_': className,
      'username': username,
      'links': links,
    };
  }
}
