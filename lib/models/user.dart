class User {
  String uuid;
  String email;
  String name;
  String? profilePictureUrl;
  String? googleUid;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    required this.uuid,
    required this.email,
    required this.name,
    this.profilePictureUrl,
    this.googleUid,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      email: json['email'],
      name: json['name'],
      profilePictureUrl: json['profile_picture_url'],
      googleUid: json['google_uid'],
      createdAt: DateTime.tryParse(json['created_at']),
      updatedAt: DateTime.tryParse(json['updated_at']),
    );
  }
}
