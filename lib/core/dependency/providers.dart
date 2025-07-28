import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../data/repositories/auth_repositories/auth_repository.dart';
import '../network/api_servise.dart';

List<SingleChildWidget> providers = [
  Provider(
    create: (context) => ApiService(),
  ),
  Provider(
    create: (context) => AuthRepository(
      client: context.read(),
    ),
  ),

];
