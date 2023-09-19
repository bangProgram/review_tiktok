import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/common/authentication/authentication_repo.dart';
import 'package:review_tiktok/navigation/videopost/repos/video_timeline_repo.dart';
import 'package:review_tiktok/navigation/videorecord/models/video_model.dart';

class VideoTimelineVM extends AsyncNotifier<List<VideoModel>> {
  late final VideoTimelineRepo _videoTimelineRepo;
  List<VideoModel> _list = [];

  Future<List<VideoModel>> _fetchVideo({int? creatAt}) async {
    final videoData = await _videoTimelineRepo.fetchVideo(creatAt: creatAt);
    final videoList = videoData.docs
        .map((video) => VideoModel.fromJson(video.data(), video.id));
    return videoList.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    _videoTimelineRepo = ref.read(videoTimelineRepo);
    _list = await _fetchVideo(creatAt: null);
    return _list;
  }

  Future<List<VideoModel>> reloadVideo() async {
    final newList = await _fetchVideo(creatAt: _list.last.creatAt);
    _list = [..._list, ...newList];
    state = AsyncValue.data(_list);
    return _list;
  }

  Future<void> refreshVideo() async {
    state = const AsyncValue.loading();
    _list = await _fetchVideo(creatAt: null);
    state = AsyncValue.data(_list);
  }

  Future<void> toggleLikeVideo(String videoId, List liker) async {
    final user = ref.read(authRepo).user!;
    if (liker.contains(user.uid)) {
      liker.remove(user.uid);
    } else {
      liker.add(user.uid);
    }
    await _videoTimelineRepo.toggleLikeVideo(videoId: videoId, liker: liker);
  }
}

final timelineProvider =
    AsyncNotifierProvider<VideoTimelineVM, List<VideoModel>>(
  () => VideoTimelineVM(),
);
