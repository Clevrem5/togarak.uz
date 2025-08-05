import 'package:togarak/core/exports.dart';

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
    if (!_formKey.currentState!.validate()) {
      debugPrint("Form xatolik bilan to‘ldirilgan.");
      return;
    }

    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Iltimos, maxfiylik siyosatiga rozilik bildiring."),
        ),
      );
      return;
    }

    final name = nameContr.text.trim();
    final surname = lastNameContr.text.trim();

    final fullData = AuthModel(name: name, surname: surname);
    context.push(Routes.signUp2, extra: fullData);
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
                          title: "Maxfiylik siyosatiga roziman",
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
                const Row(
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
                        thickness: 1,
                        indent: 30,
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return AppElevatedButton(
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
                    );
                  },
                ),
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppText(
                      title: "Allaqachon akkauntingiz bormi?",
                      size: 14,
                      color: AppColors.greyTextColor,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push(Routes.login);
                      },
                      child: const AppText(
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
