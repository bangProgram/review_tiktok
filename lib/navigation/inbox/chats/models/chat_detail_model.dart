class ChatDetailModel {
  final String text;
  final String senderId;
  final String senderNm;
  final List likes;
  final int createAt;
  final int deleteAt;

  ChatDetailModel({
    required this.text,
    required this.senderId,
    required this.senderNm,
    required this.likes,
    required this.createAt,
    required this.deleteAt,
  });

  ChatDetailModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        senderId = json['senderId'],
        senderNm = json['senderNm'],
        likes = json['likes'],
        createAt = json['createAt'],
        deleteAt = json['deleteAt'];

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'senderId': senderId,
      'senderNm': senderNm,
      'likes': likes,
      'createAt': createAt,
      'deleteAt': deleteAt,
    };
  }

  ChatDetailModel copyWith(
      {String? text,
      String? senderId,
      String? senderNm,
      List? likes,
      int? createAt,
      int? deleteAt}) {
    return ChatDetailModel(
      text: text ?? this.text,
      senderId: senderId ?? this.senderId,
      senderNm: senderNm ?? this.senderNm,
      likes: likes ?? this.likes,
      createAt: createAt ?? this.createAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }
}
