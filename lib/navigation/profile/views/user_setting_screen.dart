import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/account/login/view_models/login_view_model.dart';
import 'package:review_tiktok/navigation/profile/view_models/profile_setting_vm.dart';

class UserSettingScreen extends ConsumerWidget {
  const UserSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Setting'),
      ),
      body: ListView(
        children: [
          const AboutListTile(),
          ListTile(
            onTap: () => showAboutDialog(
              context: context,
              applicationName: 'Review_TikTok',
              applicationVersion: '1.0',
              children: [
                const Text('Review_TikTok Licenses info'),
              ],
            ),
            title: const Text('about review_tiktok'),
          ),
          SwitchListTile.adaptive(
            value: ref.watch(settingVmProvider).muted,
            onChanged: (value) {
              ref.read(settingVmProvider.notifier).setMuted(value);
            },
            title: const Text('default Mute'),
            subtitle: const Text('앱의 음소거 기본옵션 설정'),
          ),
          SwitchListTile(
            value: ref.watch(settingVmProvider).autoPlay,
            onChanged: (value) {
              ref.read(settingVmProvider.notifier).setAutoPlay(value);
            },
            title: const Text('AutoPlay'),
            subtitle: const Text('Video TimeLine 자동 재생 설정'),
          ),
          SwitchListTile.adaptive(
            title: const Text('SwitchTile'),
            value: false,
            onChanged: (value) {},
          ),
          CheckboxListTile.adaptive(
            activeColor: Colors.black,
            title: const Text('SwitchTile'),
            value: false,
            onChanged: (value) {},
          ),
          ListTile(
            onTap: () {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Are you Sure?'),
                    content: const Text('real exit?'),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          ref
                              .read(loginVMProvider.notifier)
                              .userLogout(context);
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            title: const Text('Logout'),
            subtitle: const Text('TikTok clone App ByeBye~'),
          ),
          ListTile(
            onTap: () async {
              var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2024),
              );
              print('JB : $date');
            },
            title: const Text('date picker'),
          ),
          ListTile(
            onTap: () async {
              var time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print('JB : ${time!.hour}:${time.minute}');
            },
            title: const Text('Time picker'),
          ),
          ListTile(
            onTap: () async {
              var rangeDate = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2024),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                        backgroundColor: Colors.black,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
            },
            title: const Text('Range Date picker'),
          ),
          ListTile(
            onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return CupertinoActionSheet(
                  message: const Text('Are you sure?'),
                  actions: [
                    CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            ),
            title: const Text('Cupertino popup'),
          )
        ],
      ),
    );
  }
}
