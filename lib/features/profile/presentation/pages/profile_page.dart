import 'package:togarak/core/exports.dart';
import 'package:togarak/core/widgets/app_text_field.dart';
import 'package:togarak/features/profile/presentation/widgets/profile_page_image_user_part.dart';
import 'package:togarak/features/profile/presentation/widgets/profile_page_log_out_and_reset_password_part.dart';
import 'package:togarak/features/profile/presentation/widgets/profile_page_state_edit_part.dart';

import '../../../../core/utils/app_images.dart';
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
      //70
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
              delegate: SliverChildListDelegate(
                [
                  20.verticalSpace,
                  //  Search Field
                  //48
                  AdvancedAppTextField(
                    controller: search,
                    hint: 'Izlash',
                    prefixIcon: Icons.search_sharp,
                  ),
                  10.verticalSpace,
                  // image user 104
                  ProfilePageImageUserPart(
                    share: () {},
                    delete: () {},
                    image: AppImages.profile,
                  ),
                  8.verticalSpace,
                  // malumotlar taxrirlash  230
                  ProfilePageStateEditPart(
                    callback: () {},
                    name: null,
                    surname: null,
                    birtData: null,
                    number: null,
                    gender: null,
                    email: null,
                  ),
                  8.verticalSpace,
                  // parol va chiqish
                  ProfilePageLogOutAndResetPasswordPart(
                    resetPassword: () {},
                    logOut: () {},
                  ),
                  22.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
