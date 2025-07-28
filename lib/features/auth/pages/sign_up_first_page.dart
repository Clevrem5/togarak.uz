import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:togarak/data/models/auth_models/auth_model.dart';
import 'package:togarak/features/auth/bloc/auth_bloc.dart';
import 'package:togarak/features/auth/bloc/auth_state.dart';

import '../../../core/navigation/routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/app_elevated_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_form_field.dart';
import '../widgets/selector_login.dart';

class SignUpFirstPage extends StatefulWidget {
  const SignUpFirstPage({super.key});

  @override
  State<SignUpFirstPage> createState() => _SignUpFirstPageState();
}

class _SignUpFirstPageState extends State<SignUpFirstPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameContr = TextEditingController();
  final TextEditingController lastNameContr = TextEditingController();

  bool isChecked = false;

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      debugPrint(nameContr.text);
      debugPrint(lastNameContr.text);
      final name = nameContr.text.trim();
      final surname = lastNameContr.text.trim();

      final fullData = AuthModel(
        name: name,
        surname: surname,
      );
      context.push(Routes.signUp2, extra: fullData);
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
                    children: [
                      AppTextFormField(
                        controller: nameContr,
                        hint: "Ismingiz*",
                        isHintAsteriskRed: true,
                        icon: Icons.person_outlined,
                        inputType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "Ismingizni qayta kiriting";
                          }
                          return null;
                        },
                      ),
                      12.verticalSpace,
                      AppTextFormField(
                        controller: lastNameContr,
                        hint: "Familyangiz",
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "Familyangizni qayta kiriting";
                          }
                          return null;
                        },
                      ),
                      6.verticalSpace,
                      CheckboxListTile(
                        title: const AppText(
                          title: "Maxfiylik siyosatiga rozilik",
                          weight: FontWeight.w500,
                          color: AppColors.greyTextColor,
                        ),
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        activeColor: AppColors.primaryBlueColor,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
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
                    onPressed: () => _submitForm(context),
                    text: "Keyingi qadam",
                    foregroundColor: Colors.white,
                  ),
                ),
                47.verticalSpace,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: const Color(0xFFE5E5E5),
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
                        color: const Color(0xFFE5E5E5),
                        thickness: 1,
                        indent: 30,
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
