class VideoModel {
  final String title;
  final String descript;
  final String creator;
  final String creatorUid;
  final String videoURL;
  final String thumbURL;
  final int likes;
  final int comments;
  final int creatAt;

  VideoModel({
    required this.title,
    required this.descript,
    required this.creator,
    required this.creatorUid,
    required this.videoURL,
    required this.thumbURL,
    required this.likes,
    required this.comments,
    required this.creatAt,
  });

  VideoModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        descript = json['descript'],
        creator = json['creator'],
        creatorUid = json['creatorUid'],
        videoURL = json['videoURL'],
        thumbURL = json['thumbURL'],
        likes = json['likes'],
        comments = json['comments'],
        creatAt = json['creatAt'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'descript': descript,
      'creator': creator,
      'creatorUid': creatorUid,
      'videoURL': videoURL,
      'thumbURL': thumbURL,
      'likes': likes,
      'comments': comments,
      'creatAt': creatAt,
    };
  }
}
