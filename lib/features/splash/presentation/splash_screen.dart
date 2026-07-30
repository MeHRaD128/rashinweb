import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rashinweb/features/auth/presentation/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _controller.forward();

    _timer = Timer(const Duration(milliseconds: 2300), _goToLogin);
  }

  void _goToLogin() {
    if (!mounted) return;

    Navigator.of(
      context,
    ).pushReplacement(CupertinoPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: Color(0xFF07111E),
      child: _SplashContent(),
    );
  }
}

class _SplashContent extends StatefulWidget {
  const _SplashContent();

  @override
  State<_SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<_SplashContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _scale = Tween<double>(
      begin: 0.82,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacity.value,
              child: Transform.scale(scale: _scale.value, child: child),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo-s.png',
                width: 150,
                alignment: Alignment.center,
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "RASHIN",
                    style: TextStyle(
                      fontSize: 65,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  const Text(
                    " WEB",
                    style: TextStyle(
                      fontSize: 65,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF06B6D4),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "رشد کسب و کار",
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                    ),
                  ),
                  divider(),
                  const Text(
                    "سئو",
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                    ),
                  ),
                  divider(),
                  const Text(
                    "طراحی سایت",
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget divider() => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: Container(
    width: 1,
    height: 16,
    decoration: BoxDecoration(
      color: const Color(0xFFF59E0B),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);
