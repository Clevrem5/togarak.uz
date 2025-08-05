import 'package:dartz/dartz.dart';
import 'package:togarak/features/authsecond/domain/entities/user_enetity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repositories.dart';

class LoginUseCase {
  final AuthRepository2 repository2;

  LoginUseCase(this.repository2);

  Future<Either<Failure, UserEntity>> call(String login, String password) async {
    return repository2.login(login, password);
  }
}
