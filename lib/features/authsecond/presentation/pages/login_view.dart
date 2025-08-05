import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:togarak/features/authsecond/presentation/bloc/auth2_event.dart';
import '../bloc/auth2_bloc.dart';
import '../bloc/auth2_state.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc2, AuthState2>(
        listener: (context, state) {
          if (state is AuthFailure2) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthSuccess) {
            print("success");
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              TextField(controller: emailController),
              TextField(controller: passwordController),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc2>().add(LoginSubmit(
                    emailController.text,
                    passwordController.text,
                  ));
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                 print("google login");
                },
                child: const Text('Google Login'),
              ),
            ],
          );
        },
      ),
    );
  }
}
