class ProfileUserModel {
  final String uid, name, email, birthday, bio, link;

  ProfileUserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.birthday,
    required this.bio,
    required this.link,
  });

  ProfileUserModel.empty()
      : bio = "",
        birthday = "",
        email = "",
        link = "",
        name = "",
        uid = "";

  ProfileUserModel.fromJson(Map<dynamic, dynamic> json)
      : uid = json["uid"] as String,
        email = json["email"] as String,
        name = json["name"] as String,
        birthday = json["birthday"] as String,
        link = json["link"] as String,
        bio = json["bio"] as String;

  Map<String, String> tojson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "birthday": birthday,
      "bio": bio,
      "link": link,
    };
  }
}
