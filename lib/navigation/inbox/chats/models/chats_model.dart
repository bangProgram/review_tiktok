class ChatsModel {
  final String chatId;
  final String creator;
  final String title;
  final String titleAvatar;
  final String recentMsg;
  final int createAt;
  final int changeAt;
  final List joiner;

  ChatsModel({
    required this.chatId,
    required this.creator,
    required this.title,
    required this.titleAvatar,
    required this.recentMsg,
    required this.createAt,
    required this.changeAt,
    required this.joiner,
  });

  ChatsModel.fromJson(Map<String, dynamic> json)
      : chatId = json['chatId'],
        creator = json['creator'],
        title = json['title'],
        titleAvatar = json['titleAvatar'],
        recentMsg = json['recentMsg'],
        createAt = json['createAt'],
        changeAt = json['changeAt'],
        joiner = json['joiner'];

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'creator': creator,
      'title': title,
      'titleAvatar': titleAvatar,
      'recentMsg': recentMsg,
      'createAt': createAt,
      'changeAt': changeAt,
      'joiner': joiner,
    };
  }

  ChatsModel copyWith({
    String? chatId,
    String? creator,
    String? title,
    String? titleAvatar,
    String? recentMsg,
    int? createAt,
    int? changeAt,
    List? joiner,
  }) {
    return ChatsModel(
      chatId: chatId ?? this.chatId,
      creator: creator ?? this.creator,
      title: title ?? this.title,
      titleAvatar: titleAvatar ?? this.titleAvatar,
      recentMsg: recentMsg ?? this.recentMsg,
      createAt: createAt ?? this.createAt,
      changeAt: changeAt ?? this.changeAt,
      joiner: joiner ?? this.joiner,
    );
  }
}
