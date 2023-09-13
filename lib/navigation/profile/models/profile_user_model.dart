class ProfileUserModel {
  final String uid;
  final String name;
  final String email;
  final String birthday;
  final String bio;
  final String link;
  final bool hasAvatar;

  ProfileUserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.birthday,
    required this.bio,
    required this.link,
    required this.hasAvatar,
  });

  ProfileUserModel.empty()
      : bio = "",
        birthday = "",
        email = "",
        link = "",
        name = "",
        uid = "",
        hasAvatar = false;

  ProfileUserModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"],
        name = json["name"],
        birthday = json["birthday"],
        link = json["link"],
        bio = json["bio"],
        hasAvatar = json["hasAvatar"];

  Map<String, dynamic> tojson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "birthday": birthday,
      "bio": bio,
      "link": link,
      "hasAvatar": hasAvatar,
    };
  }

  ProfileUserModel copyWith(Map<dynamic, dynamic> data) {
    return ProfileUserModel(
      uid: data['uid'] ?? uid,
      name: data['name'] ?? name,
      email: data['email'] ?? email,
      birthday: data['birthday'] ?? birthday,
      bio: data['bio'] ?? bio,
      link: data['link'] ?? link,
      hasAvatar: data['hasAvatar'] ?? hasAvatar,
    );
  }
}
