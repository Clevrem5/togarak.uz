import '../../../../core/exports.dart';
import '../../../../core/widgets/my_bottom_navigation_bar.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int selectedIndex = 0;

    if (location.startsWith(Routes.home)) {
      selectedIndex = 0;
    } else if (location.startsWith(Routes.togaraklar)) {
      selectedIndex = 1;
    } else if (location.startsWith(Routes.oilam)) {
      selectedIndex = 2;
    } else if (location.startsWith(Routes.profile)) {
      selectedIndex = 3;
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: MainBottomNavBar(
        selectedIndex: selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(Routes.home);
              break;
            case 1:
              context.go(Routes.togaraklar);
              break;
            case 2:
              context.go(Routes.oilam);
              break;
            case 3:
              context.go(Routes.profile);
              break;
          }
        },
      ),
    );
  }
}


