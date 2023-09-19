import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_user_vm.dart';
import 'package:review_tiktok/navigation/videorecord/models/video_model.dart';
import 'package:review_tiktok/navigation/videorecord/repos/video_upload_repo.dart';
import 'package:review_tiktok/navigation/views/main_nav_screen.dart';

class VideoUploadVm extends AsyncNotifier<void> {
  late final VideoUploadRepo _videoUploadRepo;

  @override
  FutureOr build() {
    _videoUploadRepo = ref.read(videoUploadRepo);
  }

  Future<void> uploadVideo(
      BuildContext context, File file, Map<String, dynamic> data) async {
    final user = ref.read(profileUserProvider).value;
    if (user != null) {
      state = const AsyncValue.loading();
      final task = await _videoUploadRepo.uploadVideoStorage(user.uid, file);
      task.whenComplete(() async {
        final videoURL = await task.snapshot.ref.getDownloadURL();

        state = await AsyncValue.guard(
          () async => await _videoUploadRepo.uploadVideoDB(
            VideoModel(
              title: data["title"],
              descript: data["descript"],
              creator: user.name,
              creatorUid: user.uid,
              fileURL: videoURL,
              thumbnailURL: "thumbnailURL",
              likes: 0,
              liker: [],
              comments: 0,
              creatAt: DateTime.now().millisecondsSinceEpoch,
              videoId: "",
            ),
          ),
        );

        context.go(MainNavScreen.routeURL);
      });
    }
  }
}

final videoUploadProvider = AsyncNotifierProvider<VideoUploadVm, void>(
  () => VideoUploadVm(),
);
