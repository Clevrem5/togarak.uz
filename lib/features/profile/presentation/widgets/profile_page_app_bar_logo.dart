import 'package:togarak/core/exports.dart';

class ProfilePageAppBarLogo extends StatelessWidget {
  const ProfilePageAppBarLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(6.4.r),
          child: SvgPicture.asset(
            AppIcons.logo,
            width: 32.w,
            height: 32.h,
          ),
        ),
        10.horizontalSpace,
        AppText(
          title: "Togarak.uz",
          size: 18.67,
          isGirloy: true,
          weight: FontWeight.w600,
        ),
      ],
    );
  }
}
