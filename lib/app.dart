import 'package:flutter/cupertino.dart';
import 'package:rashinweb/core/theme/app_theme.dart';
import 'package:rashinweb/features/splash/presentation/splash_screen.dart';

class RashinWebApp extends StatelessWidget {
  const RashinWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: SplashScreen(),
    );
  }
}
