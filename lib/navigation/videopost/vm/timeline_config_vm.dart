import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/videopost/models/timeline_config_model.dart';

class TimelineConfigVM extends AsyncNotifier<List<TimelineConfigModel>> {
  List<TimelineConfigModel> _list = [];

  Future<bool> uploadVideo() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 4));
    _list = [..._list, TimelineConfigModel(title: "${DateTime.now()}")];
    state = AsyncValue.data(_list);
    return true;
  }

  @override
  FutureOr<List<TimelineConfigModel>> build() {
    return _list;
  }
}

final timelineVmProvider =
    AsyncNotifierProvider<TimelineConfigVM, List<TimelineConfigModel>>(
  () => TimelineConfigVM(),
);
