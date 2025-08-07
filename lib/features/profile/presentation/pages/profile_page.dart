import 'package:togarak/core/exports.dart';
import 'package:togarak/features/profile/presentation/pages/app_text_field.dart';

import '../widgets/profile_page_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController search = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ProfilePageAppBar(
        settingCall: () {},
        notificationCall: () {},
        imageCall: () {},
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 19.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 20.h),
                //  Search Field
                AdvancedAppTextField(
                  controller: search,
                  hint: 'Izlash',
                  prefixIcon: Icons.search_sharp,
                ),
                10.verticalSpace,
                // image
                Container(
                  width: 336.w,
                  height: 104.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: BoxBorder.all(color: AppColors.storkeColor, width: 1),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.storkeColor,
                        blurRadius: 1,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                8.verticalSpace,
                // malumotlar taxrirlash
                Container(
                  width: 336.w,
                  height: 221.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: BoxBorder.all(color: AppColors.storkeColor, width: 1),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.storkeColor,
                        blurRadius: 1,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                8.verticalSpace,
                // parol va chiqish
                Container(
                  width: 336.w,
                  height: 142.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: BoxBorder.all(color: AppColors.storkeColor, width: 1),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.storkeColor,
                        blurRadius: 1,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      AppText(title: "title"),
                      Container(),
                      AppElevatedButton(
                        onPressed: () {
                          // context.read<AuthBloc>().add(AuthLogoutRequested());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: AppText(
                                title: "Chiqdingiz",
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        icon: Icons.logout_rounded,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        child: AppText(
                          title: "Chiqish",
                          color: Colors.red,
                          size: 12,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                22.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
