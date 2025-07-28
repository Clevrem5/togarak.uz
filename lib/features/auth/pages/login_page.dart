import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/routes.dart';
import '../../../core/network/secure_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_elevated_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/selector_login.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final phone = phoneController.text.trim();
      final password = passwordController.text.trim();

      context.read<AuthBloc>().add(
        AuthLoginRequested(phone, password),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Formani to‘g‘ri to‘ldiring")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text("Muvaffaqiyatli kirdingiz"),
              ),
            );
            context.go(Routes.home);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                gradient: LinearGradient(
                  colors: [AppColors.back1Color, AppColors.back2Color],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(alignment: Alignment.topRight, child: LanguageSelector()),
                    47.verticalSpace,
                    Center(
                      child: Column(
                        children: [
                          const AppText(
                            title: 'Kirish',
                            size: 24,
                            weight: FontWeight.w600,
                          ),
                          8.verticalSpace,
                          const AppText(
                            title: 'O‘z akkauntingiz ma‘lumotlarini kiriting',
                          ),
                        ],
                      ),
                    ),
                    47.verticalSpace,
                    Form(
                      key: _formKey,
                      child: Column(
                        spacing: 24.h,
                        children: [
                          AppTextFormField(
                            controller: phoneController,
                            hint: "Telefon raqam",
                            icon: Icons.phone_outlined,
                            inputType: TextInputType.phone,
                          ),
                          AppTextFormField(
                            controller: passwordController,
                            hint: "Parol",
                            icon: Icons.lock_outline_rounded,
                            isObscure: true,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return "Parol 6 ta belgidan kam bo‘lmasligi kerak";
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                context.push(Routes.home); // yoki forget-password
                              },
                              child: const AppText(
                                title: "Parolni unutdim",
                                color: AppColors.darkColor,
                                weight: FontWeight.w500,
                                decor: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.verticalSpace,
                    Column(
                      children: [
                        AppElevatedButton(
                          onPressed: ()  => _submitForm(context),
                          text: isLoading ? "Yuklanmoqda..." : "Kirish",
                          foregroundColor: Colors.white,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final token = await SecureStorage.readToken();
                            debugPrint("🎯 Token (UIdan): $token");
                          },
                          child: const Text("Tokenni ko‘r"),
                        ),
                      ],
                    ),
                    47.verticalSpace,
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFE5E5E5),
                            thickness: 1,
                            endIndent: 30,
                          ),
                        ),
                        const AppText(
                          title: "Yoki",
                          color: AppColors.greyHintColor,
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFE5E5E5),
                            height: 50,
                            indent: 40,
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    AppElevatedButton(
                      onPressed: () {
                        context.push(Routes.signUp2);
                      },
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.darkColor,
                      text: "Google orqali kirish",
                      leadIcon: SvgPicture.asset(
                        'assets/icons/google.svg',
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(
                          title: "Akkauntingiz yo'qmi?",
                          size: 14,
                          color: AppColors.greyTextColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push(Routes.signUp1);
                          },
                          child: const AppText(
                            title: "Ro'yxatdan o'tish",
                            color: AppColors.darkColor,
                            weight: FontWeight.w500,
                            decor: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
