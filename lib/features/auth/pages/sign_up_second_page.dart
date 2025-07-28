import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:togarak/features/auth/bloc/auth_state.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_elevated_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../../../data/models/auth_models/auth_model.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../widgets/selector_login.dart';

class SignUpSecondPage extends StatelessWidget {
  SignUpSecondPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController phoneContr = TextEditingController();
  final TextEditingController passwordContr = TextEditingController();
  final TextEditingController confirmParolContr = TextEditingController();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final phone = phoneContr.text.trim();
      final String confirm = confirmParolContr.text.trim();
      final data = GoRouterState.of(context).extra as AuthModel;
      final fullData = data.copyWith(phone: phone, password: confirm);
      print("To‘liq model: ${fullData.toJson()}");
      context.read<AuthBloc>().add(AuthSignUpRequested(fullData));
      context.push(Routes.home);
    } else {
      context.pop();
      debugPrint("Form xatolik bilan to‘ldirilgan.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 24.h,
          ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppElevatedButton(
                      onPressed: () => context.pop(),
                      width: 95,
                      height: 38,
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.darkColor,
                      leadIcon: Icon(Icons.arrow_back),
                      text: "Ortga",
                      splashColor: Colors.black.withOpacity(0.1),
                      splashFactory: InkRipple.splashFactory,
                    ),
                    LanguageSelector(),
                  ],
                ),
                47.verticalSpace,
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        title: "Ro'yxatdan o'tish",
                        size: 24,
                        weight: FontWeight.w600,
                      ),
                      8.verticalSpace,
                      AppText(title: "O'zingiz uchun yangi akkaunt yarating"),
                    ],
                  ),
                ),
                47.verticalSpace,
                Form(
                  key: _formKey,
                  child: Column(
                    spacing: 12.h,
                    children: [
                      AppTextFormField(
                        controller: phoneContr,
                        hint: "Telefon raqam yoki email*",
                        icon: Icons.phone_outlined,
                        inputType: TextInputType.phone,
                        isHintAsteriskRed: true, // faqat kerak bo‘lsa true qilasiz
                      ),
                      AppTextFormField(
                        controller: passwordContr,
                        hint: "Parol*",
                        isHintAsteriskRed: true,
                        icon: Icons.lock_outline_rounded,
                        enableObscureToggleForNumbers: true,
                        isObscure: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Parol 6 ta belgidan kam bo‘lmasligi kerak";
                          }
                          return null;
                        },
                      ),
                      AppTextFormField(
                        controller: confirmParolContr,
                        hint: "Parolni tasdiqlash*",
                        isHintAsteriskRed: true,
                        icon: Icons.lock_outline_rounded,
                        enableObscureToggleForNumbers: true,
                        isObscure: true,
                        validator: (value) {
                          if (value == null) {
                            return "Parol 6 ta belgidan kam bo‘lmasligi kerak";
                          } else if (value != passwordContr.text) {
                            return "Parol bilan mos emas!";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                24.verticalSpace,
                BlocListener<AuthBloc, AuthState>(
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
                  child: AppElevatedButton(
                    onPressed: () =>_submitForm(context),
                    text: "Ro'yxatdan o'tish",
                    foregroundColor: Colors.white,
                  ),
                ),
                47.verticalSpace,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Color(0xFFE5E5E5),
                        thickness: 1,
                        endIndent: 30,
                      ),
                    ),
                    AppText(
                      title: "Yoki",
                      color: AppColors.greyHintColor,
                    ),
                    Expanded(
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
                  onPressed: () {},
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
                    AppText(
                      title: "Allaqachon akkauntingiz bormi?",
                      size: 14,
                      color: AppColors.greyTextColor,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(Routes.login);
                      },
                      child: AppText(
                        title: "Kirish",
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
      ),
    );
  }
}
