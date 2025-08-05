
import 'package:togarak/core/exports.dart';

var providers = <SingleChildWidget>[
  Provider(
    create: (context) => ApiService(),
  ),
  Provider(
    create: (context) => AuthRepository(
      client: context.read(),
    ),
  ),

];
