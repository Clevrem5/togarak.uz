import 'package:dartz/dartz.dart';
import 'package:togarak/features/authsecond/data/datasource/auth_remote_datasourse.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user_enetity.dart';
import '../../domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository2 {
  final AuthRemoteDataSources remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, UserEntity>> login(String login, String password) async {
    try{
      final user =await remote.login(login, password);
      return Right(user);
    }catch (e){
      return Left(ServiseFailure(e.toString()));
    }
  }


}
