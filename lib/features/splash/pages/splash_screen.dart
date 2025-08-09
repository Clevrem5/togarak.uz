import 'dart:async';

import '../../../core/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
    Timer(const Duration(seconds: 3), () async {
      String? token = await SecureStorage.readToken();
      if (!mounted) return;
      if (token != null && token.isNotEmpty) {
        context.go(Routes.profile);
      } else {
        context.go(Routes.signUp1);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(100),
            child: SvgPicture.asset(
              AppIcons.logo,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
