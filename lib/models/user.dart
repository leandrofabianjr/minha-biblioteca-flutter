class User {
  String? uuid;
  String email;
  String name;
  String? profilePictureUrl;
  String? googleUid;
  String? createdAt;
  String? updatedAt;

  User({
    this.uuid,
    required this.email,
    required this.name,
    this.profilePictureUrl,
    this.googleUid,
    this.createdAt,
    this.updatedAt,
  });
}
