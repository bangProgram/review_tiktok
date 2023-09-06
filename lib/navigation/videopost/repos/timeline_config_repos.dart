import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/videopost/models/timeline_config_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimelineConfigRepos extends AsyncNotifier<List<TimelineConfigModel>> {
  final List<TimelineConfigModel> _list = [];

  @override
  FutureOr<List<TimelineConfigModel>> build() {
    return _list;
  }
}
