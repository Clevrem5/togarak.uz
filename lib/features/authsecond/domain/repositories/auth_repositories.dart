import 'package:dartz/dartz.dart';
import 'package:togarak/features/authsecond/domain/entities/user_enetity.dart';
import '../../../../core/error/failure.dart';

abstract class AuthRepository2{
  Future<Either<Failure,UserEntity>>login(String login,String password);
}