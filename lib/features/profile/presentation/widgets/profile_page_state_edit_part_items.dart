import 'package:togarak/core/exports.dart';

class ProfilePageStateEditPartItems extends StatelessWidget {
  const ProfilePageStateEditPartItems({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154.w,
      height: 49.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.backround2Color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2.h,
        children: [
          AppText(
            title: title,
            size: 10,
            weight: FontWeight.w500,
            color: AppColors.greyHintColor,
          ),
          AppText(
            title: text,
            size: 12,
            weight: FontWeight.w600,
            color: AppColors.darkColor,
          ),
        ],
      ),
    );
  }
}
