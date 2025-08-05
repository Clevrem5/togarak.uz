import 'package:togarak/core/exports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppText(title: " Welcome Home"),
      ),
    );
  }
}
