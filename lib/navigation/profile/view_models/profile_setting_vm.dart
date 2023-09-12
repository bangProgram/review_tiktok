import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/profile/models/profile_setting_model.dart';
import 'package:review_tiktok/navigation/profile/repos/profile_setting_repo.dart';

class ProfileSettingVM extends Notifier<ProfileSettingModel> {
  final ProfileSettingRepo repository;

  ProfileSettingVM(this.repository);

  void setMuted(bool value) {
    repository.setMuted(value);
    state = ProfileSettingModel(
      muted: value,
      autoPlay: state.autoPlay,
    );
  }

  void setAutoPlay(bool value) {
    repository.setAutoPlay(value);
    state = ProfileSettingModel(
      muted: state.muted,
      autoPlay: value,
    );
  }

  @override
  ProfileSettingModel build() {
    return ProfileSettingModel(
      muted: repository.getMuted(),
      autoPlay: repository.getAutoPlay(),
    );
  }
}

final settingVmProvider =
    NotifierProvider<ProfileSettingVM, ProfileSettingModel>(
  () => throw UnimplementedError(),
);
