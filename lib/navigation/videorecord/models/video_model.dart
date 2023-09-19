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
  final List liker;
  final String videoId;

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
    required this.liker,
    required this.videoId,
  });

  VideoModel.fromJson(Map<String, dynamic> json, String id)
      : title = json['title'],
        descript = json['descript'],
        creator = json['creator'],
        creatorUid = json['creatorUid'],
        fileURL = json['fileURL'],
        thumbnailURL = json['thumbnailURL'],
        likes = json['likes'],
        liker = json['liker'],
        comments = json['comments'],
        creatAt = json['creatAt'],
        videoId = id;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'descript': descript,
      'creator': creator,
      'creatorUid': creatorUid,
      'fileURL': fileURL,
      'thumbnailURL': thumbnailURL,
      'likes': likes,
      'liker': liker,
      'comments': comments,
      'creatAt': creatAt,
    };
  }
}
