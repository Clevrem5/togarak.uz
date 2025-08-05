import 'package:togarak/core/exports.dart';

class SignUpSecondPage extends StatelessWidget {
  SignUpSecondPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneContr = TextEditingController();
  final TextEditingController passwordContr = TextEditingController();
  final TextEditingController confirmParolContr = TextEditingController();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final phone = phoneContr.text.trim();
      final confirm = confirmParolContr.text.trim();
      final data = GoRouterState.of(context).extra as AuthModel;
      final fullData = data.copyWith(phone: phone, password: confirm);
      context.read<AuthBloc>().add(AuthSignUpRequested(fullData));
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
              SnackBar(content: Text(state.message)),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppElevatedButton(
                          onPressed: () => context.pop(),
                          width: 95,
                          height: 38,
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.darkColor,
                          leadIcon: const Icon(Icons.arrow_back),
                          text: "Ortga",
                          splashColor: Colors.black.withValues(alpha: 0.1),
                          splashFactory: InkRipple.splashFactory,
                        ),
                        const LanguageSelector(),
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
                            isHintAsteriskRed: true,
                          ),
                          AppTextFormField(
                            controller: passwordContr,
                            hint: "Parol*",
                            icon: Icons.lock_outline_rounded,
                            isObscure: true,
                            isHintAsteriskRed: true,
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
                            icon: Icons.lock_outline_rounded,
                            isObscure: true,
                            isHintAsteriskRed: true,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return "Parol 6 ta belgidan kam bo‘lmasligi kerak";
                              }
                              if (value != passwordContr.text) {
                                return "Parollar mos emas!";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    24.verticalSpace,
                    AppElevatedButton(
                      onPressed: () => _submitForm(context),
                      text: isLoading ? "Yuklanmoqda..." : "Ro'yxatdan o'tish",
                      foregroundColor: Colors.white,
                    ),
                    47.verticalSpace,
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(color: Color(0xFFE5E5E5), thickness: 1, endIndent: 30),
                        ),
                        AppText(title: "Yoki", color: AppColors.greyHintColor),
                        Expanded(
                          child: Divider(color: Color(0xFFE5E5E5), height: 50, indent: 40),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    AppElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(GoogleSignInRequest());
                      },
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.darkColor,
                      text: isLoading ? "Yuklanmoqda..." : "Google orqali kirish",
                      leadIcon: SvgPicture.asset(
                        AppIcons.google,
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
                        SizedBox(width: 4),
                        GestureDetector(
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
          );
        },
      ),
    );
  }
}
