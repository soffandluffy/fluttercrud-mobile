class User {
  final int id;
  final String name;
  final String bio;
  final String email;
  final String avatar;
  final String joinedOn;

  User.fromJson(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'] ?? 0,
        name = jsonMap['name'] ?? '',
        bio = jsonMap['bio'] ?? '',
        email = jsonMap['email'] ?? '',
        avatar = jsonMap['avatar'] ?? '',
        joinedOn = jsonMap['created_at'] ?? '';
}
