import 'package:google_sign_in/google_sign_in.dart';
import 'package:togarak/core/servise/api_servise.dart';
import 'package:togarak/features/authsecond/data/models/user_model.dart';

class AuthRemoteDataSources {
  final ApiService api;

  AuthRemoteDataSources(this.api);

  Future<UserModel> login(String login, String password) async {
    final response = await api.post("auth/v2/login", {
      "phone": login,
      "user_password": password,
    });
    return UserModel.fromJson(response.data['user']);
  }

  // Future<UserModel> loginWithGoogle() async {
  //   final googleSignIn = GoogleSignIn.instance;
  //   final account = await googleSignIn.signOut();
  //
  //   // if (account == null) {
  //   //   throw Exception("Google Sign In cancelled");
  //   // }
  //   //
  //   // final email = account.email;
  //   // final displayName = account.displayName ?? "NoName";
  //   //
  //   final response = await api.post('/auth/v2/google-login', {
  //     "google_email": "email",
  //     "display_name": "displayName",
  //   });
  //
  //   return UserModel.fromJson(response.data['user']);
  // }
}
