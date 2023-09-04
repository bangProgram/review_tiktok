import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_tiktok/common/config/change_noti_config.dart';

class UserSettingScreen extends StatefulWidget {
  const UserSettingScreen({super.key});

  @override
  State<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
  bool _isSelected = false;

  void _onSelect(bool? select) {
    if (select != null) {
      setState(() {
        _isSelected = select;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          AnimatedBuilder(
            animation: changeNotiConfig,
            builder: (context, child) {
              return SwitchListTile.adaptive(
                value: changeNotiConfig.autoMute,
                onChanged: (value) {
                  changeNotiConfig.onToggleMute();
                },
                title: const Text('default Mute'),
                subtitle: const Text('앱의 음소거 기본옵션 설정'),
              );
            },
          ),
          AnimatedBuilder(
              animation: changeNotiConfig,
              builder: (context, child) {
                return SwitchListTile(
                  value: changeNotiConfig.isDarkMode,
                  onChanged: (value) {
                    changeNotiConfig.onToggleDarkMode();
                    MediaQuery.of(context).platformBrightness;
                  },
                  title: const Text('DarkMode'),
                  subtitle: const Text('앱의 다크모드 설정'),
                );
              }),
          SwitchListTile.adaptive(
            title: const Text('SwitchTile'),
            value: _isSelected,
            onChanged: _onSelect,
          ),
          CheckboxListTile.adaptive(
            activeColor: Colors.black,
            title: const Text('SwitchTile'),
            value: _isSelected,
            onChanged: _onSelect,
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

              print(
                  'JB : ${rangeDate!.start.year}-${rangeDate.start.month}-${rangeDate.start.day}');
              print(
                  'JB : ${rangeDate.end.year}-${rangeDate.end.month}-${rangeDate.end.day}');
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
