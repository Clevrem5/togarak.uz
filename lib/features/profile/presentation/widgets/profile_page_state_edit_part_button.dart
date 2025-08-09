import 'package:togarak/core/exports.dart';

class ProfilePageStateEditPartButton extends StatelessWidget {
  const ProfilePageStateEditPartButton({
    super.key,
    required this.callback,
  });

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          title: "Shaxsiy ma'lumotlar",
          size: 14,
          height: 1,
          weight: FontWeight.w600,
        ),
        AppElevatedButton(
          onPressed: callback,
          icon: Icons.edit_outlined,
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primaryBlueColor,
          width: 118.w,
          height: 38.h,
          child: AppText(
            title: "Tahrirlash",
            size: 12,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
