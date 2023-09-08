import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:review_tiktok/firebase_options.dart';
import 'package:review_tiktok/generated/l10n.dart';
import 'package:review_tiktok/navigation/profile/repos/setting_config_repo.dart';
import 'package:review_tiktok/navigation/profile/vm/setting_config_vm.dart';
import 'package:review_tiktok/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final preferences = await SharedPreferences.getInstance();
  final repository = SettingConfigRepo(preferences);

  runApp(
    ProviderScope(
      overrides: [
        settingVmProvider.overrideWith(
          () => SettingConfigVm(repository),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    S.load(const Locale('ko'));
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      localizationsDelegates: const [
        S.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: Typography.blackMountainView,
        primaryColor: const Color.fromARGB(255, 255, 68, 55),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade200,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: Typography.whiteMountainView,
        primaryColor: const Color.fromARGB(255, 255, 68, 55),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade800,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}
