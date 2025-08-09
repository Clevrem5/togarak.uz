import 'package:togarak/core/exports.dart';

class ProfilePageImageUserPartButton extends StatelessWidget {
  const ProfilePageImageUserPartButton({
    super.key, required this.callback, required this.icon,
  });
  final VoidCallback callback;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 114.w,
        height: 38.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          border: BoxBorder.all(color: AppColors.storkeColor, width: 1.2),
          color: Colors.white,
        ),
        child: icon,
      ),
    );
  }
}
