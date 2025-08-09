import 'package:togarak/core/exports.dart';
import 'package:togarak/features/home/presentation/pages/main_scaffold.dart';
import 'package:togarak/features/oilam/presentation/pages/oilam_page.dart';
import 'package:togarak/features/profile/presentation/pages/profile_page.dart';
import 'package:togarak/features/splash/pages/splash_screen.dart';
import 'package:togarak/features/togaraklarim/presentation/pages/togarak_page.dart';

class AppRouter {
  static final GoRouter routes = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(
            repository: context.read(),
          ),
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: Routes.signUp1,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(
            repository: context.read(),
          ),
          child: SignUpFirstPage(),
        ),
      ),

      GoRoute(
        path: Routes.signUp2,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(
            repository: context.read(),
          ),
          child: SignUpSecondPage(),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) => HomePage(),
          ),
          GoRoute(
            path: Routes.togaraklar,
            builder: (context, state) => TogarakPage(),
          ),
          GoRoute(
            path: Routes.oilam,
            builder: (context, state) => OilamPage(),
          ),
          GoRoute(
            path: Routes.profile,
            builder: (context, state) => ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => SplashScreen(),
      ),
    ],
  );
}
