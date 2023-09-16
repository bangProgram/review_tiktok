class VideoModel {
  final String title;
  final String descript;
  final String creator;
  final String creatorUid;
  final String fileURL;
  final String thumbnailURL;
  final int likes;
  final int comments;
  final int creatAt;

  VideoModel({
    required this.title,
    required this.descript,
    required this.creator,
    required this.creatorUid,
    required this.fileURL,
    required this.thumbnailURL,
    required this.likes,
    required this.comments,
    required this.creatAt,
  });

  VideoModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        descript = json['descript'],
        creator = json['creator'],
        creatorUid = json['creatorUid'],
        fileURL = json['fileURL'],
        thumbnailURL = json['thumbnailURL'],
        likes = json['likes'],
        comments = json['comments'],
        creatAt = json['creatAt'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'descript': descript,
      'creator': creator,
      'creatorUid': creatorUid,
      'fileURL': fileURL,
      'thumbnailURL': thumbnailURL,
      'likes': likes,
      'comments': comments,
      'creatAt': creatAt,
    };
  }
}
