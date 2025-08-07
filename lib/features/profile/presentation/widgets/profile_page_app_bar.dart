import 'dart:io';

import 'package:togarak/core/exports.dart';
import 'package:togarak/features/profile/presentation/widgets/profile_page_app_bar_buttons.dart';
import 'package:togarak/features/profile/presentation/widgets/profile_page_app_bar_logo.dart';

class ProfilePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfilePageAppBar({
    super.key,
    required this.settingCall,
    required this.notificationCall,
    required this.imageCall,
    this.image,
  });

  final VoidCallback settingCall;
  final VoidCallback notificationCall;
  final VoidCallback imageCall;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 21),
      child: AppBar(
        leadingWidth: 150,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: ProfilePageAppBarLogo(),
        ),
        actionsPadding: EdgeInsetsGeometry.symmetric(horizontal: 15),
        actions: [
          Row(
            spacing: 8.w,
            children: [
              ProfilePageAppBarButtons(
                icon: Icons.settings_outlined,
                callback: settingCall,
              ),
              ProfilePageAppBarButtons(
                icon: Icons.notifications_none_outlined,
                callback: notificationCall,
              ),
              ProfilePageAppBarUserImage(
                callback: imageCall,
                image: image,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 70);
}

class ProfilePageAppBarUserImage extends StatelessWidget {
  const ProfilePageAppBarUserImage({
    super.key,
    this.image,
    required this.callback,
  });

  final File? image;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 48.w,
        height: 48.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(100),
          color: AppColors.primaryBlueColor,
        ),
        child: image != null
            ? Image.file(image!)
            : Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              ),
      ),
    );
  }
}
