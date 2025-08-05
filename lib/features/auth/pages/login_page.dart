import 'package:togarak/core/exports.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final phone = phoneController.text.trim().replaceAll('+', '');
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
                            addUzbekPrefix: true,

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
                          onPressed: () => _submitForm(context),
                          text: isLoading ? "Yuklanmoqda..." : "Kirish",
                          foregroundColor: Colors.white,
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
