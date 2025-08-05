import 'package:togarak/features/authsecond/domain/entities/user_enetity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String login,
    required String name,
  }) : super(id: id, login: login, name: name);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      login: json["login"],
      name: json['name'],
    );
  }

  Map<String,dynamic>toJson()=>{
    "id":id,
    "login":login,
    "name":name,
  };
}
