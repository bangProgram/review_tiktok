import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/videopost/models/timeline_config_model.dart';
import 'package:review_tiktok/navigation/videopost/repos/timeline_config_repos.dart';

class TimelineConfigVM extends Notifier<TimelineConfigModel> {
  final TimelineConfigRepos _repository;

  TimelineConfigVM(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = TimelineConfigModel(
      muted: value,
      autoPlay: state.autoPlay,
    );
  }

  void setAutoPlay(bool value) {
    _repository.setAutoPlay(value);
    state = TimelineConfigModel(
      muted: state.muted,
      autoPlay: value,
    );
  }

  @override
  TimelineConfigModel build() {
    return TimelineConfigModel(
      muted: _repository.getMuted(),
      autoPlay: _repository.getAutoPlay(),
    );
  }
}

final timelineConfigProvider =
    NotifierProvider<TimelineConfigVM, TimelineConfigModel>(
  () => throw UnimplementedError(),
);
