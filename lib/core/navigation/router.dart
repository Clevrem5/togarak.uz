import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:togarak/core/navigation/routes.dart';
import 'package:togarak/data/repositories/auth_repositories/auth_repository.dart';
import 'package:togarak/features/auth/bloc/auth_bloc.dart';
import 'package:togarak/features/auth/pages/login_page.dart';
import 'package:togarak/features/auth/pages/sign_up_first_page.dart';
import 'package:togarak/features/auth/pages/sign_up_second_page.dart';
import 'package:togarak/features/home/pages/home_page.dart';
import 'package:togarak/main.dart';

class AppRouter {
  static final GoRouter routes = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Routes.signUp1,
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(
            repo: context.read<AuthRepository>(),
          ),
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: Routes.signUp1,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(
            repo: context.read(),
          ),
          child: SignUpFirstPage(),
        ),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: Routes.signUp2,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthBloc(
            repo: context.read(),
          ),
          child: SignUpSecondPage(),
        ),
      ),
    ],
  );
}
