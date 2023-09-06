import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/navigation/profile/models/setting_config_model.dart';
import 'package:review_tiktok/navigation/profile/repos/setting_config_repo.dart';

class SettingConfigVm extends Notifier<SettingConfigModel> {
  final SettingConfigRepo repository;

  SettingConfigVm(this.repository);

  void setMuted(bool value) {
    repository.setMuted(value);
    state = SettingConfigModel(
      muted: value,
      autoPlay: state.autoPlay,
    );
  }

  void setAutoPlay(bool value) {
    repository.setAutoPlay(value);
    state = SettingConfigModel(
      muted: state.muted,
      autoPlay: value,
    );
  }

  @override
  SettingConfigModel build() {
    return SettingConfigModel(
      muted: repository.getMuted(),
      autoPlay: repository.getAutoPlay(),
    );
  }
}

final settingVmProvider = NotifierProvider<SettingConfigVm, SettingConfigModel>(
  () => throw UnimplementedError(),
);
