import 'package:togarak/core/exports.dart';

class ProfilePageAppBarButtons extends StatelessWidget {
  const ProfilePageAppBarButtons({
    super.key,
    required this.icon,
    required this.callback,
  });

  final IconData icon;
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
          color: Colors.white,
          border: BoxBorder.all(color: AppColors.storkeColor, width: 1),
        ),
        child: Icon(
          icon,
          color: AppColors.darkColor,
          size: 20,
        ),
      ),
    );
  }
}
