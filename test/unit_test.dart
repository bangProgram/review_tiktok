// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:review_tiktok/navigation/videorecord/models/video_model.dart';

void main() {
  group("VideoModel group", () {
    test("Test Const", () {
      final video = VideoModel(
        title: "title",
        descript: "descript",
        creator: "creator",
        creatorUid: "creatorUid",
        fileURL: "fileURL",
        thumbnailURL: "thumbnailURL",
        likes: 0,
        comments: 0,
        creatAt: 0,
        liker: [],
        videoId: "videoId",
      );

      expect(video.videoId, "videoId");
    });

    test("Test from Json", () {
      final videoModel = VideoModel.fromJson({
        'title': 'title',
        'descript': 'descript',
        'creator': 'creator',
        'creatorUid': 'creatorUid',
        'fileURL': 'fileURL',
        'thumbnailURL': 'thumbnailURL',
        'likes': 0,
        'liker': [],
        'comments': 0,
        'creatAt': 0,
      }, "videoId");

      expect(videoModel.title, 'title');
      expect(videoModel.comments, isInstanceOf<int>());
      expect(videoModel.likes, greaterThanOrEqualTo(0));
    });

    test("test to json", () {
      final video = VideoModel(
        title: "title",
        descript: "descript",
        creator: "creator",
        creatorUid: "creatorUid",
        fileURL: "fileURL",
        thumbnailURL: "thumbnailURL",
        likes: 0,
        comments: 0,
        creatAt: 0,
        liker: [],
        videoId: "videoId",
      );

      final json = video.toJson();
      expect(json['title'], 'title');
      expect(json['title'], isInstanceOf<String>());
      expect(json['likes'], isInstanceOf<int>());
    });
  });
}
